Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA1B7D186C
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Oct 2023 23:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbjJTVuJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Oct 2023 17:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbjJTVuJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Oct 2023 17:50:09 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B906A9E
        for <linux-integrity@vger.kernel.org>; Fri, 20 Oct 2023 14:50:02 -0700 (PDT)
Received: from [192.168.86.69] (unknown [50.46.228.62])
        by linux.microsoft.com (Postfix) with ESMTPSA id E990520B74C0;
        Fri, 20 Oct 2023 14:50:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E990520B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1697838602;
        bh=cWz2Q33BnG1puqH1h9DLKBeEmDZ1FtFEiqsZ9kfPdNI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TyC8VjOI5OX3GhQfXdqkvUDvNiAVYjc5q4SIWpxOwGlS/A1A/KIp0bb7mfq/cYoLV
         AizKZot4sBoyJTnx6V3XGNiPpuYcsBgl98qBHFYqBF1tEGOjvShzwy6S0d2WbINELj
         Sr4R45VCLA3HGp+veFduURxAV5oca6KY7SGDF1Ec=
Message-ID: <97927bf8-77d3-5117-7e49-41b76f308930@linux.microsoft.com>
Date:   Fri, 20 Oct 2023 14:50:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/7] ima: refactor ima_dump_measurement_list to move
 memory allocation to a separate function
Content-Language: en-US
To:     Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
        ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
        kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
 <20231005182602.634615-2-tusharsu@linux.microsoft.com>
 <2c06f9c5-6f3a-b163-20ca-24178d7cba4e@linux.ibm.com>
 <9b227c0a-ddb3-b1c3-4ed0-e3e740db7788@linux.microsoft.com>
 <f60a08b3-408b-05e0-2c91-9c19159c7fd2@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <f60a08b3-408b-05e0-2c91-9c19159c7fd2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-20.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 10/20/23 14:21, Stefan Berger wrote:
> 
> On 10/20/23 16:33, Tushar Sugandhi wrote:
>> Thanks a lot Stefan for reviewing this series.
>> Really appreciate it.
> 
> 
> You are welcome.
> 
> What may be a bit problematic is the fact that between the time the 
> buffer for the flattened IMA log is allocated (kexec 'load') and the 
> time it is filled (kexec 'exec') that the log may grow quite a bit. I 
> would say that the size of the growths may depend a lot on how people 
> are using their system that the additional kilobytes  may or may not be 
> enough. So a distro would probably have to specify additional bytes to 
> allocate for like the worst case. But how many kilobytes is the worst case?
> 
>     Stefan
Yes.  Its a genuine concern.

The window between kexec 'load' and 'execute' could be arbitrarily long.
(hours, days, months).  And the log can grow quite a bit.  And there is
always a possibility that it will run out of the extra allocated memory-
no matter how much we allocate at load.

We can never know with certainty - how many kilobytes is the worst case?
So I used another approach to address this issue.

I addressed this issue in patch 7/7 of this series[1] by measuring
a marker event ("kexec_execute") just before kexec 'execute'.
Also pasting the code from 7/7 below[1] for reference.

If IMA runs out of the extra allocated memory while copying the events,
this marker event ("kexec_execute") will not be present in the IMA log
when the system boots into the new Kernel.

So the event sequence in IMA log would be as follows:

IMA log
--------
'boot_aggregate' # clean boot
...
... # events before new kexec 'load'
...
'kexec_load'
...
...# arbitrary many more events
...
...
...
'kexec_execute'
#if this 'kexec_execute' event is missing after the
#system kexec soft boots into the new Kernel,
#i.e. between the two boot_aggregate events,
#it can be safely concluded that the IMA log
#ran out of memory in during kexec reboot,
#and now it is out of sync with PCR quotes
#and thus the system needs to be hard rebooted.

'boot_aggregate' # clean boot
...
... # events after kexec soft boot
...

This logic can effectively conclude if IMA log is out of
sync with the PCR quotes.  If it is, then the remote
attestation service/client can take appropriate action
on the system (clean boot) to recover.


Hope this approach makes sense.

~Tushar


[1] [v2,7/7] ima: record log size at kexec load and execute
https://patchwork.kernel.org/project/linux-integrity/patch/20231005182602.634615-8-tusharsu@linux.microsoft.com/ 


diff --git a/security/integrity/ima/ima_kexec.c 
b/security/integrity/ima/ima_kexec.c
index 6cd5f46a7208..0f9c424fe808 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -17,6 +17,8 @@
  #include "ima.h"

  #ifdef CONFIG_IMA_KEXEC
+#define IMA_KEXEC_EVENT_LEN 128
+
  struct seq_file ima_kexec_file;
  struct ima_kexec_hdr ima_khdr;
  static void *ima_kexec_buffer;
@@ -34,6 +36,8 @@  void ima_clear_kexec_file(void)

  static int ima_alloc_kexec_buf(size_t kexec_segment_size)
  {
+	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
+
  	if ((kexec_segment_size == 0) ||
  	    (kexec_segment_size == ULONG_MAX) ||
  	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
@@ -64,6 +68,12 @@  static int ima_alloc_kexec_buf(size_t 
kexec_segment_size)
  	memset(&ima_khdr, 0, sizeof(ima_khdr));
  	ima_khdr.version = 1;

+	scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
+		  "kexec_segment_size=%lu;", kexec_segment_size);
+
+	ima_measure_critical_data("ima_kexec", "kexec_load", ima_kexec_event,
+				  strlen(ima_kexec_event), false, NULL, 0);
+
  	return 0;
  }

@@ -198,6 +208,7 @@  void ima_add_kexec_buffer(struct kimage *image)
  static int ima_update_kexec_buffer(struct notifier_block *self,
  				   unsigned long action, void *data)
  {
+	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
  	void *buf = NULL;
  	size_t buf_size;
  	bool resume = false;
@@ -213,9 +224,31 @@  static int ima_update_kexec_buffer(struct 
notifier_block *self,
  		return NOTIFY_OK;
  	}

+	buf_size = ima_get_binary_runtime_size();
+	scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
+		  "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;",
+		  kexec_segment_size, buf_size);
+
+	/*
+	 * This is one of the very last events measured by IMA before kexec
+	 * soft rebooting into the new Kernal.
+	 * This event can be used as a marker after the system soft reboots
+	 * to the new Kernel to check if there was sufficient memory allocated
+	 * at kexec 'load' to capture the events measured between the window
+	 * of kexec 'load' and 'execute'.
+	 * This event needs to be present in the IMA log, in between the two
+	 * 'boot_aggregate' events that are logged for the previous boot and
+	 * the current soft reboot. If it is not present after the system soft
+	 * reboots into the new Kernel, it would mean the IMA log is not
+	 * consistent with the TPM PCR quotes, and the system needs to be
+	 * cold-booted for the attestation to succeed again.
+	 */
+	ima_measure_critical_data("ima_kexec", "kexec_execute",
+				  ima_kexec_event, strlen(ima_kexec_event),
+				  false, NULL, 0);
+
  	ima_measurements_suspend();

-	buf_size = ima_get_binary_runtime_size();
  	ret = ima_dump_measurement_list(&buf_size, &buf,
  					kexec_segment_size);

