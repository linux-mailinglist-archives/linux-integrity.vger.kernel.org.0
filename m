Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08C17D8D65
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Oct 2023 05:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjJ0D0O (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Oct 2023 23:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbjJ0D0N (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Oct 2023 23:26:13 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99386129
        for <linux-integrity@vger.kernel.org>; Thu, 26 Oct 2023 20:26:10 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39R3MLKi002744;
        Fri, 27 Oct 2023 03:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=zhaiPMeLQ80QhVz+4CRLvcHnc+KySMeU3dhECAb4LkA=;
 b=oIp/3oDdrUuh34HgOwFNoTwZznM6sB8zA9TZtX9Z77ysaSeBWn5PF9cLqidzoUV4CrBq
 ioxVAckYXIkHl3iBgoj7qjESMrjfrp7Li9L1tDGsgEb1FkktG93l9VHnd9fHPfHv50KO
 MIg96eFPqOwhxeg5sO1OIsWkkHkmHSKVfmenZ9gquQ5kvSUqDQJPrKt4Wv25CDzSg2Sd
 sTENBPxS3GnNck0RPejLmBwRAT3G8m20xPE/ipUoh63c6058IZaFzFgMAi9RrCozeqey
 Bpw0Ueyr+pAd5ee1ouXu+yGe42uzdIWylPkR4SxwoZDX/L2gvm/oSgVzdAVAG8iJUdif Cw== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u0588g2tt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 03:25:50 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39R110D8021491;
        Fri, 27 Oct 2023 03:25:49 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tywqrabug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 03:25:49 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39R3Pnj920054594
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 03:25:49 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDAA458056;
        Fri, 27 Oct 2023 03:25:48 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6AB225803F;
        Fri, 27 Oct 2023 03:25:48 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.171.37])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 27 Oct 2023 03:25:48 +0000 (GMT)
Message-ID: <e4e92a1816475596b91bbbb2fdf33c11ce375cf1.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/7] ima: refactor ima_dump_measurement_list to move
 memory allocation to a separate function
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
        kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date:   Thu, 26 Oct 2023 23:25:48 -0400
In-Reply-To: <1aa5524b52fdb46df4948a21b1139cf833758cde.camel@linux.ibm.com>
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
         <20231005182602.634615-2-tusharsu@linux.microsoft.com>
         <1aa5524b52fdb46df4948a21b1139cf833758cde.camel@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JrPa0dbZ4HtCYKzMYqbDw7Dt41pFFOCN
X-Proofpoint-ORIG-GUID: JrPa0dbZ4HtCYKzMYqbDw7Dt41pFFOCN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_22,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 bulkscore=0 spamscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310240000 definitions=main-2310270028
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-10-26 at 16:16 -0400, Mimi Zohar wrote:
> Hi Tushar,
> 
> According to Documentation/process/submitting-patches.rst, the subject
> line should be between 70-75 characters.
> 
> Perhaps something like "ima: define and call ima_alloc_kexec_buffer()".
> 
> On Thu, 2023-10-05 at 11:25 -0700, Tushar Sugandhi wrote:
> > IMA allocates memory and dumps the measurement during kexec soft reboot
> > as a single function call ima_dump_measurement_list().  It gets called
> > during kexec 'load' operation.  It results in the IMA measurements
> > between the window of kexec 'load' and 'execute' getting dropped when the
> > system boots into the new Kernel.  One of the kexec requirements is the
> > segment size cannot change between the 'load' and the 'execute'.
> > Therefore, to address this problem, ima_dump_measurement_list() needs
> > to be refactored to allocate the memory at kexec 'load', and dump the
> > measurements at kexec 'execute'.  The function that allocates the memory
> > should handle the scenario where the kexec load is called multiple times
> 
> The above pragraph is unnecessary.
> 
> > Refactor ima_dump_measurement_list() to move the memory allocation part
> > to a separate function ima_alloc_kexec_buf() to allocate buffer of size
> > 'kexec_segment_size' at kexec 'load'.  Make the local variables in
> > function ima_dump_measurement_list() global, so that they can be accessed
> > from ima_alloc_kexec_buf().  Make necessary changes to the function
> > ima_add_kexec_buffer() to call the above two functions.
> 
> Fix the wording based on the suggested changes below.
> 
> > Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> 
> - Before re-posting this patch set, verify there aren't any
> "checkpatch.pl --strict" issues.
> - After applying each patch, compile the kernel and verify it still
> works.

Doing this will detect whether or not the patch set is bisect safe.

> > ---
> >  security/integrity/ima/ima_kexec.c | 126 +++++++++++++++++++++--------
> >  1 file changed, 93 insertions(+), 33 deletions(-)
> > 
> > diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> > index 419dc405c831..307e07991865 100644
> > --- a/security/integrity/ima/ima_kexec.c
> > +++ b/security/integrity/ima/ima_kexec.c
> > @@ -15,61 +15,114 @@
> >  #include "ima.h"
> >  
> >  #ifdef CONFIG_IMA_KEXEC
> > +struct seq_file ima_kexec_file;
> 
> Define "ima_kexec_file" as static since it only used in this file.  
> Since the variable does not need to be global, is there still a reason
> for changing its name?   Minimize code change.

Adding "static" would make ima_kexec_file a global static variable. 
Please ignore my comment about reverting the variable name change.

Mimi

> 
> > +struct ima_kexec_hdr ima_khdr;
> > +
> > +void ima_clear_kexec_file(void)
> 
> The opposite of "set" is "clear" (e.g. set_git, clear_bit).  The
> opposite of "alloc" would be "free" (e.g. ima_alloc_kexec_buf,
> ima_free_kexec_buf)
> 
> > +{
> > +	vfree(ima_kexec_file.buf);
> > +	ima_kexec_file.buf = NULL;
> > +	ima_kexec_file.size = 0;
> > +	ima_kexec_file.read_pos = 0;
> > +	ima_kexec_file.count = 0;
> > +}
> > +
> > +static int ima_alloc_kexec_buf(size_t kexec_segment_size)
> > +{
> > +	if ((kexec_segment_size == 0) ||
> > +	    (kexec_segment_size == ULONG_MAX) ||
> > +	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
> > +		pr_err("%s: Invalid segment size for kexec: %zu\n",
> > +			__func__, kexec_segment_size);
> > +		return -EINVAL;
> > +	}
> 
> Please avoid code duplication.  If moving the test here, then remove it
> from its original place.
> 
> > +
> > +	/*
> > +	 * If kexec load was called before, clear the existing buffer
> > +	 * before allocating a new one
> > +	 */
> 
> > +	if (ima_kexec_file.buf)
> > +		ima_clear_kexec_file();
> 
> Perhaps instead of always freeing the buffer, check and see whether the
> size has changed.  If it hasn't changed, then simply return.  If it has
> changed, perhaps use realloc().  Possible wording:
> 
> "Kexec may be called multiple times.  Free and re-alloc the buffer if
> the size changed."
> 
> > +
> > +	/* segment size can't change between kexec load and execute */
> > +	ima_kexec_file.buf = vmalloc(kexec_segment_size);
> > +	if (!ima_kexec_file.buf) {
> > +		pr_err("%s: No memory for ima kexec measurement buffer\n",
> > +			__func__);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	ima_kexec_file.size = kexec_segment_size;
> > +	ima_kexec_file.read_pos = 0;
> > +	ima_kexec_file.count = sizeof(ima_khdr);	/* reserved space */
> > +
> > +	memset(&ima_khdr, 0, sizeof(ima_khdr));
> > +	ima_khdr.version = 1;
> > +
> > +	return 0;
> > +}
> > +
> >  static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
> >  				     unsigned long segment_size)
> >  {
> >  	struct ima_queue_entry *qe;
> > -	struct seq_file file;
> > -	struct ima_kexec_hdr khdr;
> >  	int ret = 0;
> >  
> > -	/* segment size can't change between kexec load and execute */
> > -	file.buf = vmalloc(segment_size);
> > -	if (!file.buf) {
> > -		ret = -ENOMEM;
> > -		goto out;
> > +	if (!ima_kexec_file.buf) {
> > +		pr_err("%s: Kexec file buf not allocated\n",
> > +			__func__);
> > +		return -EINVAL;
> >  	}
> >  
> > -	file.size = segment_size;
> > -	file.read_pos = 0;
> > -	file.count = sizeof(khdr);	/* reserved space */
> > +	/*
> > +	 * Ensure the kexec buffer is large enough to hold ima_khdr
> > +	 */
> > +	if (ima_kexec_file.size < sizeof(ima_khdr)) {
> > +		pr_err("%s: Kexec buffer size too low to hold ima_khdr\n",
> > +			__func__);
> > +		ima_clear_kexec_file();
> > +		return -ENOMEM;
> > +	}
> 
> Is this necessary?
>  
> > -	memset(&khdr, 0, sizeof(khdr));
> > -	khdr.version = 1;
> > +	/*
> > +	 * If we reach here, then there is enough memory
> > +	 * of size kexec_segment_size in ima_kexec_file.buf
> > +	 * to copy at least partial IMA log.
> > +	 * Make best effort to copy as many IMA measurements
> > +	 * as possible.
> > +	 */
> 
> Suggestion:
> 
> /* Copy as many IMA measurements list records as possible */
> 
> >  	list_for_each_entry_rcu(qe, &ima_measurements, later) {
> > -		if (file.count < file.size) {
> > -			khdr.count++;
> > -			ima_measurements_show(&file, qe);
> > +		if (ima_kexec_file.count < ima_kexec_file.size) {
> > +			ima_khdr.count++;
> > +			ima_measurements_show(&ima_kexec_file, qe);
> >  		} else {
> > -			ret = -EINVAL;
> > +			ret = EFBIG;
> > +			pr_err("%s: IMA log file is too big for Kexec buf\n",
> > +				__func__);
> >  			break;
> >  		}
> >  	}
> >  
> > -	if (ret < 0)
> > -		goto out;
> > -
> >  	/*
> >  	 * fill in reserved space with some buffer details
> >  	 * (eg. version, buffer size, number of measurements)
> >  	 */
> > -	khdr.buffer_size = file.count;
> > +	ima_khdr.buffer_size = ima_kexec_file.count;
> >  	if (ima_canonical_fmt) {
> > -		khdr.version = cpu_to_le16(khdr.version);
> > -		khdr.count = cpu_to_le64(khdr.count);
> > -		khdr.buffer_size = cpu_to_le64(khdr.buffer_size);
> > +		ima_khdr.version = cpu_to_le16(ima_khdr.version);
> > +		ima_khdr.count = cpu_to_le64(ima_khdr.count);
> > +		ima_khdr.buffer_size = cpu_to_le64(ima_khdr.buffer_size);
> >  	}
> > -	memcpy(file.buf, &khdr, sizeof(khdr));
> > +	memcpy(ima_kexec_file.buf, &ima_khdr, sizeof(ima_khdr));
> >  
> >  	print_hex_dump_debug("ima dump: ", DUMP_PREFIX_NONE, 16, 1,
> > -			     file.buf, file.count < 100 ? file.count : 100,
> > +			     ima_kexec_file.buf, ima_kexec_file.count < 100 ?
> > +			     ima_kexec_file.count : 100,
> >  			     true);
> >  
> > -	*buffer_size = file.count;
> > -	*buffer = file.buf;
> > -out:
> > -	if (ret == -EINVAL)
> > -		vfree(file.buf);
> > +	*buffer_size = ima_kexec_file.count;
> > +	*buffer = ima_kexec_file.buf;
> > +
> >  	return ret;
> >  }
> 


