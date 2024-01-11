Return-Path: <linux-integrity+bounces-751-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EECF182B80B
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Jan 2024 00:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 639261F25C01
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jan 2024 23:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A575A0E3;
	Thu, 11 Jan 2024 23:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OKVjwNRb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402CC5A0E0
	for <linux-integrity@vger.kernel.org>; Thu, 11 Jan 2024 23:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 985AC20B3CC4;
	Thu, 11 Jan 2024 15:29:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 985AC20B3CC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1705015751;
	bh=AsPnRUrMFpIrUpYkVrHdeq1HV9N//zJSvvWcLdw4/JE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OKVjwNRbt5+WfRi9Ehw1RrJbio0JT0oEbphQUMsGBw3rOQhfVBT/xL+v/hVTImJO2
	 rJ5JZt1C61JrgDJ9LzdFED3INOJtH7rnfp7xh3CCHYMeni5NRlhNRXcUdB/bjX74Df
	 jsH8u1pP53w7W8QLYUXz1OU8Y9ktPcs/dO91OMlg=
Message-ID: <c2ec280f-4789-4654-a7b4-7a9534476173@linux.microsoft.com>
Date: Thu, 11 Jan 2024 15:29:10 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] ima: kexec: move ima log copy from kexec load to
 execute
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huaweicloud.com,
 roberto.sassu@huawei.com, eric.snowberg@oracle.com, stefanb@linux.ibm.com,
 ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
 <20231216010729.2904751-3-tusharsu@linux.microsoft.com>
 <b01df40e800ab387d43adcbb7f643bcd9f172cbb.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <b01df40e800ab387d43adcbb7f643bcd9f172cbb.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Apologies for the late response on this particular patch (v3 2/7) Mimi.
I was on vacation in December.
I was meaning to respond to this one when I came back, but I was caught 
in between other work items last few days. Sorry if it caused any 
confusion.

Responses below.

On 12/20/23 11:02, Mimi Zohar wrote:
> Hi Tushar,
> 
> On Fri, 2023-12-15 at 17:07 -0800, Tushar Sugandhi wrote:
>> ima_dump_measurement_list() is called from  ima_add_kexec_buffer() during
>> kexec 'load', which may result in loss of IMA measurements between kexec
>> 'load' and 'execute'.  It needs to be called during kexec 'execute'.
>>
>> Implement ima_update_kexec_buffer(), to be called during kexec 'execute'.
>> Move ima_dump_measurement_list() function call from ima_add_kexec_buffer()
>> to ima_update_kexec_buffer().  Make the needed variables global for
>> accessibility during kexec 'load' and 'execute'. Implement and call
>> ima_measurements_suspend() and ima_measurements_resume() to help ensure
>> the integrity of the IMA log during copy. Add a reboot notifier_block to
>> trigger ima_update_kexec_buffer() during kexec soft-reboot.  Exclude ima
>> segment from calculating and storing digest in function
>> kexec_calculate_store_digests(), since ima segment can be modified
>> after the digest is computed during kexec 'load'.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> 
> Wow!   That's quite a bit for a single patch.
> 
> This patch moves the ima_dump_measurement_list() call from kexec load
> to exec, but doesn't register the reboot notifier in this patch.  I
> don't see how it is possible with just the previous and this patch
> applied that the measurement list is carried across kexec.
Ah. That's a good catch.
I was only checking if I can boot into the Kernel for testing 
bisect-safe readiness for each patch.  I will ensure the move of 
ima_dump_measurement_list() and registering the reboot notifier at 
execute stays an atomic operation in a single patch.


> 
> Please test after applying each patch in the patch set to make sure
> that the measurement list is properly carried across kexec.
> 
Yup. I was only checking if I can boot into the Kernel after each patch.
My bad. :(

Going forward, I will check each patch for the measurement list carry 
over after kexec.

> Additional inline comments below.
> 
>> ---
>>   include/linux/kexec.h              |  3 ++
>>   kernel/kexec_file.c                |  8 ++++
>>   security/integrity/ima/ima.h       |  2 +
>>   security/integrity/ima/ima_kexec.c | 61 +++++++++++++++++++++++++-----
>>   security/integrity/ima/ima_queue.c | 19 ++++++++++
>>   5 files changed, 84 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index 22b5cd24f581..fd94404acc66 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -366,6 +366,9 @@ struct kimage {
>>   
>>   	phys_addr_t ima_buffer_addr;
>>   	size_t ima_buffer_size;
>> +
>> +	unsigned long ima_segment_index;
>> +	bool is_ima_segment_index_set;
>>   #endif
>>   
>>   	/* Core ELF header buffer */
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index f989f5f1933b..bf758fd5062c 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -734,6 +734,14 @@ static int kexec_calculate_store_digests(struct kimage *image)
>>   		if (ksegment->kbuf == pi->purgatory_buf)
>>   			continue;
>>   
>> +		/*
>> +		 * Skip the segment if ima_segment_index is set and matches
>> +		 * the current index
>> +		 */
>> +		if (image->is_ima_segment_index_set &&
>> +		    i == image->ima_segment_index)
>> +			continue;
> 
> With this change, the IMA segment is not included in the digest
> calculation, nor should it be included in the digest verification.
> However, I'm not seeing the matching code change in the digest
> verification.
> 
Fair question.

But I don't think anything else needs to be done here.

The way kexec_calculate_store_digests() and verify_sha256_digest()
are implemented, it already skips verification of the segments if
the segment is not part of 'purgatory_sha_regions'.

In kexec_calculate_store_digests(), my change is to 'continue' when the
segment is the IMA segment when the function is going through all the
segments in a for loop [1].

Therefore in kexec_calculate_store_digests() -
  - crypto_shash_update() is not called for IMA segment [1].
  - sha_regions[j] is not updated with IMA segment  [1].
  - This 'sha_regions' variable later becomes 'purgatory_sha_regions'
    in kexec_calculate_store_digests  [1].
  - and verify_sha256_digest() only verifies 'purgatory_sha_regions'[2].

  Since IMA segment is not part of the 'purgatory_sha_regions', it is
  not included in the verification as part of verify_sha256_digest().

I have pasted the relevant code below for quick reference [1][2].

> Please make ignoring the IMA segment a separate patch.
> 
Sure. Will do.

>>   		ret = crypto_shash_update(desc, ksegment->kbuf,
>>   					  ksegment->bufsz);
>>   		if (ret)
...
...
...
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index c29db699c996..49a6047dd8eb 100644
> 
> Suspending and resuming extending the measurement list should be a
> separate patch as well, with its own patch description.
> 
Sure. Will do.
>>   /*
>>    * Add template entry to the measurement list and hash table, and
>>    * extend the pcr.
> 
----------------------------------------------------------------------------------
Reference code in the context of kexec_calculate_store_digests()
and verify_sha256_digest() conversation above.
----------------------------------------------------------------------------------
[1]
https://lore.kernel.org/all/20231216010729.2904751-3-tusharsu@linux.microsoft.com/
/* Calculate and store the digest of segments */
static int kexec_calculate_store_digests(struct kimage *image)
{
...
...

      for (j = i = 0; i < image->nr_segments; i++) {
            struct kexec_segment *ksegment;

            ksegment = &image->segment[i];
            /*
             * Skip purgatory as it will be modified once we put digest
             * info in purgatory.
             */
            if (ksegment->kbuf == pi->purgatory_buf)
                  continue;

+           /*
+            * Skip the segment if ima_segment_index is set and matches
+            * the current index
+            */
+           if (image->is_ima_segment_index_set &&
+               i == image->ima_segment_index)
+                 continue;
+
            ret = crypto_shash_update(desc, ksegment->kbuf,
                                ksegment->bufsz);
            if (ret)
                  break;

            /*
             * Assume rest of the buffer is filled with zero and
             * update digest accordingly.
             */
            nullsz = ksegment->memsz - ksegment->bufsz;
            while (nullsz) {
                  unsigned long bytes = nullsz;

                  if (bytes > zero_buf_sz)
                        bytes = zero_buf_sz;
                  ret = crypto_shash_update(desc, zero_buf, bytes);
                  if (ret)
                        break;
                  nullsz -= bytes;
            }

            if (ret)
                  break;

            sha_regions[j].start = ksegment->mem;
            sha_regions[j].len = ksegment->memsz;
            j++;
      }

      if (!ret) {
            ret = crypto_shash_final(desc, digest);
            if (ret)
                  goto out_free_digest;
            ret = kexec_purgatory_get_set_symbol(image, 
"purgatory_sha_regions",
                                         sha_regions, sha_region_sz, 0);
            if (ret)
                  goto out_free_digest;

            ret = kexec_purgatory_get_set_symbol(image, 
"purgatory_sha256_digest",
                                         digest, SHA256_DIGEST_SIZE, 0);
            if (ret)
                  goto out_free_digest;
      }

out_free_digest:
      kfree(digest);
out_free_sha_regions:
      vfree(sha_regions);
out_free_desc:
      kfree(desc);
out_free_tfm:
      kfree(tfm);
out:
      return ret;
}
---------------------------------------------------------------------------
[2] 
https://elixir.bootlin.com/linux/latest/source/arch/x86/purgatory/purgatory.c#L24

u8 purgatory_sha256_digest[SHA256_DIGEST_SIZE] 
__section(".kexec-purgatory");

struct kexec_sha_region purgatory_sha_regions[KEXEC_SEGMENT_MAX] 
__section(".kexec-purgatory");

static int verify_sha256_digest(void)
{
      struct kexec_sha_region *ptr, *end;
      u8 digest[SHA256_DIGEST_SIZE];
      struct sha256_state sctx;

      sha256_init(&sctx);
      end = purgatory_sha_regions + ARRAY_SIZE(purgatory_sha_regions);

      for (ptr = purgatory_sha_regions; ptr < end; ptr++)
            sha256_update(&sctx, (uint8_t *)(ptr->start), ptr->len);

      sha256_final(&sctx, digest);

      if (memcmp(digest, purgatory_sha256_digest, sizeof(digest)))
            return 1;

      return 0;
}

Thanks,
Tushar

