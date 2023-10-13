Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A0C7C7ADE
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Oct 2023 02:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343497AbjJMAd3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Oct 2023 20:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344236AbjJMAd2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Oct 2023 20:33:28 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A621BB7
        for <linux-integrity@vger.kernel.org>; Thu, 12 Oct 2023 17:33:26 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39D0Wvi7000867;
        Fri, 13 Oct 2023 00:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=S3ImQL78BLt+KZ58dxuhdHSGJ7USfPeI2lxulz9U6+I=;
 b=D2WiELTdWPQgFTbjLS7TwD6O31aN79+scnU9z9+O6KSaSUoqDjpYOMAUVqu/ZpZ3uSJ6
 6LBe8nrBqz91u+IyLC8ZUfHMxRPmWPZaUmUgvAzEZd7D60eYTV90GE3os4VRptcUuVbh
 r4S+Q2D3HpGZ3aKsuUu1Zk4LeLMloxJkvOOdOEw2ahzs4Yx+vap1EbweyxzD55hiiX9F
 DDngtQISQDuj2Uywg60m3djl6JgtHeCKK/+gvAamwGzMweiYHtM4Re8YM4pjm72DQVYV
 XTg48sReRqb18o433WvF7UY4uL4lFu0VAyCv/aJXmrb75PhYg9QtgCm3m8znt0FEP2Mx ag== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpu6gra7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 00:32:59 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39CN4Hu5029739;
        Fri, 13 Oct 2023 00:28:47 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tpt5bgeah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 00:28:47 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39D0SktB22217266
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 00:28:46 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CE3158056;
        Fri, 13 Oct 2023 00:28:46 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D76A958052;
        Fri, 13 Oct 2023 00:28:45 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 13 Oct 2023 00:28:45 +0000 (GMT)
Message-ID: <2c06f9c5-6f3a-b163-20ca-24178d7cba4e@linux.ibm.com>
Date:   Thu, 12 Oct 2023 20:28:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v2 1/7] ima: refactor ima_dump_measurement_list to move
 memory allocation to a separate function
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        zohar@linux.ibm.com, ebiederm@xmission.com, noodles@fb.com,
        bauermann@kolabnow.com, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
 <20231005182602.634615-2-tusharsu@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20231005182602.634615-2-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RPc60-KnVkz8QuVMzY0IvSqVBQOUPhHD
X-Proofpoint-GUID: RPc60-KnVkz8QuVMzY0IvSqVBQOUPhHD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_14,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310130003
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 10/5/23 14:25, Tushar Sugandhi wrote:
> IMA allocates memory and dumps the measurement during kexec soft reboot
> as a single function call ima_dump_measurement_list().  It gets called
> during kexec 'load' operation.  It results in the IMA measurements
> between the window of kexec 'load' and 'execute' getting dropped when the
> system boots into the new Kernel.  One of the kexec requirements is the
> segment size cannot change between the 'load' and the 'execute'.
> Therefore, to address this problem, ima_dump_measurement_list() needs
> to be refactored to allocate the memory at kexec 'load', and dump the
> measurements at kexec 'execute'.  The function that allocates the memory
> should handle the scenario where the kexec load is called multiple times.
>
> Refactor ima_dump_measurement_list() to move the memory allocation part
> to a separate function ima_alloc_kexec_buf() to allocate buffer of size
> 'kexec_segment_size' at kexec 'load'.  Make the local variables in
> function ima_dump_measurement_list() global, so that they can be accessed
> from ima_alloc_kexec_buf().  Make necessary changes to the function
> ima_add_kexec_buffer() to call the above two functions.
>
> Signed-off-by: Tushar Sugandhi<tusharsu@linux.microsoft.com>
> ---
>   security/integrity/ima/ima_kexec.c | 126 +++++++++++++++++++++--------
>   1 file changed, 93 insertions(+), 33 deletions(-)
>
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 419dc405c831..307e07991865 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -15,61 +15,114 @@
>   #include "ima.h"
>   
>   #ifdef CONFIG_IMA_KEXEC
> +struct seq_file ima_kexec_file;
> +struct ima_kexec_hdr ima_khdr;

Since you are only populating the buffer at kexec 'execute' time, you 
should be able to move this header into the function where it is needed.


> +
> +void ima_clear_kexec_file(void)
> +{
> +	vfree(ima_kexec_file.buf);
I would pass the ima_kexec_file onto this function here as a parameter 
rather than accessing the file-static variable. I find this better to 
read once you look at ima_clear_kexec_file() further below and wonder 
why it doesn't take a parameter.
> +	ima_kexec_file.buf = NULL;
> +	ima_kexec_file.size = 0;
> +	ima_kexec_file.read_pos = 0;
> +	ima_kexec_file.count = 0;
> +}
> +
> +static int ima_alloc_kexec_buf(size_t kexec_segment_size)

Call it segment size to avoid the later kexec_segment_size static 
variable in this file.


> +{
> +	if ((kexec_segment_size == 0) ||
> +	    (kexec_segment_size == ULONG_MAX) ||
> +	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {

These tests are already done before ima_alloca_kexec_buf() is called. 
Also, kexec_segment_size cannot be 0.


> +		pr_err("%s: Invalid segment size for kexec: %zu\n",
> +			__func__, kexec_segment_size);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * If kexec load was called before, clear the existing buffer
> +	 * before allocating a new one
> +	 */
> +	if (ima_kexec_file.buf)
> +		ima_clear_kexec_file();
> +

ima_clear_file(&ima_kexec_file);


> +	/* segment size can't change between kexec load and execute */
> +	ima_kexec_file.buf = vmalloc(kexec_segment_size);
> +	if (!ima_kexec_file.buf) {
> +		pr_err("%s: No memory for ima kexec measurement buffer\n",
> +			__func__);
> +		return -ENOMEM;
> +	}
> +
> +	ima_kexec_file.size = kexec_segment_size;
> +	ima_kexec_file.read_pos = 0;
> +	ima_kexec_file.count = sizeof(ima_khdr);	/* reserved space */
> +
> +	memset(&ima_khdr, 0, sizeof(ima_khdr));
> +	ima_khdr.version = 1;

Move this into ima_dump_measurement_list() since it's only used there 
once and getting rid of this file-static variable is a plus.


> +
> +	return 0;
> +}
> +
>   static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>   				     unsigned long segment_size)
>   {
>   	struct ima_queue_entry *qe;
> -	struct seq_file file;
> -	struct ima_kexec_hdr khdr;
Don't remove it from here.
>   	int ret = 0;
>   
> -	/* segment size can't change between kexec load and execute */
> -	file.buf = vmalloc(segment_size);
> -	if (!file.buf) {
> -		ret = -ENOMEM;
> -		goto out;
> +	if (!ima_kexec_file.buf) {
> +		pr_err("%s: Kexec file buf not allocated\n",
> +			__func__);
> +		return -EINVAL;
>   	}
>   
> -	file.size = segment_size;
> -	file.read_pos = 0;
> -	file.count = sizeof(khdr);	/* reserved space */
> +	/*
> +	 * Ensure the kexec buffer is large enough to hold ima_khdr
> +	 */
> +	if (ima_kexec_file.size < sizeof(ima_khdr)) {
> +		pr_err("%s: Kexec buffer size too low to hold ima_khdr\n",
> +			__func__);
> +		ima_clear_kexec_file();
> +		return -ENOMEM;
> +	}
>   
> -	memset(&khdr, 0, sizeof(khdr));
> -	khdr.version = 1;
> +	/*
> +	 * If we reach here, then there is enough memory
> +	 * of size kexec_segment_size in ima_kexec_file.buf
> +	 * to copy at least partial IMA log.
> +	 * Make best effort to copy as many IMA measurements
> +	 * as possible.
You can reformat these comments to (at least) 80 columns.

> +	 */
>   	list_for_each_entry_rcu(qe, &ima_measurements, later) {
> -		if (file.count < file.size) {
> -			khdr.count++;
> -			ima_measurements_show(&file, qe);
> +		if (ima_kexec_file.count < ima_kexec_file.size) {
> +			ima_khdr.count++;
> +			ima_measurements_show(&ima_kexec_file, qe);
>   		} else {
> -			ret = -EINVAL;
> +			ret = EFBIG;

Hm, you are not looking for EFBIG after calling this function and the 
overrun could actually also happen in the ima_measurement_show() above 
and go unreported if this is the last element.

if (ima_kexec_file.count < ima_kexec_file.size) {
	ima_khdr.count++;
	ima_measurements_show(&ima_kexec_file, qe);
}

if (ima_kexec_file.count >= ima_kexec_file.size) {
	/* leave ret = 0; caller doesn't need to worry about undersized buffer */
	pr_err("%s: IMA log file is too big for Kexec buf\n",
		__func__);
	break;
}

> +			pr_err("%s: IMA log file is too big for Kexec buf\n",
> +				__func__);
>   			break;
>   		}
>   	}
>   
> -	if (ret < 0)
> -		goto out;
> -
>   	/*
>   	 * fill in reserved space with some buffer details
>   	 * (eg. version, buffer size, number of measurements)
>   	 */
> -	khdr.buffer_size = file.count;
> +	ima_khdr.buffer_size = ima_kexec_file.count;
>   	if (ima_canonical_fmt) {
> -		khdr.version = cpu_to_le16(khdr.version);
> -		khdr.count = cpu_to_le64(khdr.count);
> -		khdr.buffer_size = cpu_to_le64(khdr.buffer_size);
> +		ima_khdr.version = cpu_to_le16(ima_khdr.version);
> +		ima_khdr.count = cpu_to_le64(ima_khdr.count);
> +		ima_khdr.buffer_size = cpu_to_le64(ima_khdr.buffer_size);
>   	}
> -	memcpy(file.buf, &khdr, sizeof(khdr));
> +	memcpy(ima_kexec_file.buf, &ima_khdr, sizeof(ima_khdr));
>   
>   	print_hex_dump_debug("ima dump: ", DUMP_PREFIX_NONE, 16, 1,
> -			     file.buf, file.count < 100 ? file.count : 100,
> +			     ima_kexec_file.buf, ima_kexec_file.count < 100 ?
> +			     ima_kexec_file.count : 100,
>   			     true);
>   
> -	*buffer_size = file.count;
> -	*buffer = file.buf;
> -out:
> -	if (ret == -EINVAL)
> -		vfree(file.buf);
> +	*buffer_size = ima_kexec_file.count;
> +	*buffer = ima_kexec_file.buf;
> +
>   	return ret;
>   }
>   
> @@ -108,13 +161,20 @@ void ima_add_kexec_buffer(struct kimage *image)
>   		return;
>   	}
>   
> -	ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
> -				  kexec_segment_size);
> -	if (!kexec_buffer) {
> +	ret = ima_alloc_kexec_buf(kexec_segment_size);
> +	if (ret < 0) {
>   		pr_err("Not enough memory for the kexec measurement buffer.\n");
>   		return;
>   	}
>   
> +	ret = ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
> +					kexec_segment_size);
> +	if (ret < 0) {
> +		pr_err("%s: Failed to dump IMA measurements. Error:%d.\n",
> +		       __func__, ret);
> +		return;
> +	}
> +
>   	kbuf.buffer = kexec_buffer;
>   	kbuf.bufsz = kexec_buffer_size;
>   	kbuf.memsz = kexec_segment_size;
