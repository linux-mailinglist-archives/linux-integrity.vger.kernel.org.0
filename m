Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECC16164DD
	for <lists+linux-integrity@lfdr.de>; Tue,  7 May 2019 15:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfEGNp0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 May 2019 09:45:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46644 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726304AbfEGNp0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 May 2019 09:45:26 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x47DiisM034813
        for <linux-integrity@vger.kernel.org>; Tue, 7 May 2019 09:45:24 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sbb0vgd53-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 07 May 2019 09:45:22 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 7 May 2019 14:44:51 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 7 May 2019 14:44:48 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x47DilL846334026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 May 2019 13:44:47 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8947A5C9E;
        Tue,  7 May 2019 13:44:46 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 626B3A5C9F;
        Tue,  7 May 2019 13:44:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.95.148])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  7 May 2019 13:44:46 +0000 (GMT)
Subject: Re: [PATCH] integrity: keep the integrity state of open files up to
 date
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Janne Karhunen <janne.karhunen@gmail.com>,
        linux-integrity@vger.kernel.org, konsta.karsisto@gmail.com
Date:   Tue, 07 May 2019 09:44:35 -0400
In-Reply-To: <20190506125341.5872-1-janne.karhunen@gmail.com>
References: <20190506125341.5872-1-janne.karhunen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19050713-4275-0000-0000-0000033247A0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050713-4276-0000-0000-00003841B30D
Message-Id: <1557236675.3971.89.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-07_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905070090
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-05-06 at 15:53 +0300, Janne Karhunen wrote:
> From: Janne Karhunen <Janne.Karhunen@gmail.com>
> 
> When a file is open for writing, kernel crash or power outage
> is guaranteed to corrupt the inode integrity state leading to
> file appraisal failure on the subsequent boot. Add some basic
> infrastructure to keep the integrity measurements up to date as
> the files are written to.
> 
> Core file operations (open, close, sync, msync, truncate)
> update the measurement immediately. In order to maintain
> sufficient write performance for writes, add a latency tunable
> delayed work workqueue for computing the re-measurements.

Would renaming or deleting the file affect the wq?

> Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
> Signed-off-by: Konsta Karsisto <konsta.karsisto@gmail.com>

Good, by only touching the "collected" iint status, re-measuring/re-
appraising files shouldn't be affected.

As I don't I have a test environment for testing this sort of change,
once the patches are ready, please Cc other interested parties.
 Probably some of the embedded mailing lists, yocto, and Patrick Ohly.

<snip>

> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index dc12fbcf484c..796147dbde37 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -20,6 +20,8 @@ extern int ima_bprm_check(struct linux_binprm *bprm);
>  extern int ima_file_check(struct file *file, int mask);
>  extern void ima_post_create_tmpfile(struct inode *inode);
>  extern void ima_file_free(struct file *file);
> +extern void ima_file_update(struct file *file);
> +extern void ima_delayed_update(struct file *file);
>  extern int ima_file_mmap(struct file *file, unsigned long prot);
>  extern int ima_load_data(enum kernel_load_data_id id);
>  extern int ima_read_file(struct file *file, enum kernel_read_file_id id);

Instead of using ifdef's before calling these functions, define the
associated stub functions as well.

 
> +/**
> + * ima_delayed_update - add a file to delayed update list
> + * @file: pointer to file structure being updated
> + */
> +void ima_delayed_update(struct file *file)
> +{
> +	struct inode *inode = file_inode(file);
> +	struct integrity_iint_cache *iint;
> +	unsigned long blocks;
> +	unsigned long msecs;
> +	bool creq;
> +
> +	iint = integrity_iint_find(inode);
> +	if (!iint)
> +		return;
> +
> +	if (iint->ima_work.file)
> +		return;
> +
> +	/* Slow down the samping rate per the file size */
> +	blocks = inode->i_size / SZ_1M + 1;
> +	msecs = blocks * IMA_LATENCY_INCREMENT;
> +	if (msecs > CONFIG_IMA_HASH_LATENCY_CEILING)
> +		msecs = CONFIG_IMA_HASH_LATENCY_CEILING;
> +
> +	get_file(file);
> +	iint->ima_work.file = file;
> +	INIT_DELAYED_WORK(&iint->ima_work.work, ima_delayed_update_handler);
> +
> +	creq = queue_delayed_work(ima_update_wq,
> +				  &iint->ima_work.work,
> +				  msecs_to_jiffies(msecs));
> +	if (creq == false) {
> +		iint->ima_work.file = NULL;
> +		fput(file);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(ima_delayed_update);

Does this need to be exported?

> +
> +/**
> + * ima_file_update - update the file measurement
> + * @file: pointer to file structure being updated
> + */
> +void ima_file_update(struct file *file)
> +{
> +	struct inode *inode = file_inode(file);
> +	struct integrity_iint_cache *iint;
> +	bool should_measure = true;
> +	u64 i_version;
> +
> +	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
> +		return;
> +
> +	iint = integrity_iint_find(inode);
> +	if (!iint)
> +		return;
> +
> +	mutex_lock(&iint->mutex);
> +	clear_bit(IMA_UPDATE_XATTR, &iint->atomic_flags);
> +	if (IS_I_VERSION(inode)) {
> +		i_version = inode_query_iversion(inode);
> +		if (i_version == iint->version)
> +			should_measure = false;
> +	}
> +	if (should_measure) {
> +		iint->flags &= ~IMA_COLLECTED;
> +		ima_update_xattr(iint, file);
> +	}
> +	mutex_unlock(&iint->mutex);
> +}
> +EXPORT_SYMBOL_GPL(ima_file_update);

And here?

Mimi

