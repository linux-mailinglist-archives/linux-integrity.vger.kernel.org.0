Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D403131406B
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Feb 2021 21:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236795AbhBHUZ7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Feb 2021 15:25:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40356 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236831AbhBHUZj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Feb 2021 15:25:39 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 118K3GSl106203;
        Mon, 8 Feb 2021 15:24:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=E2Vl0L4InxHZSx1+Ng/3nKMdG9/JrjbnMCLeby9KtuY=;
 b=CCW5Hsy9oLneS63k2TuZ4ZM8ggNadutIw2MpcaMDJcvMQrnfawjbULiXj4V6EVUdroB6
 kbNUcCBAQNLyAWH6HMeqKvK7O1EgxI8nqrM6Glf0kPHot4A4RBtKfJNKiZ5c8PlAMuyn
 47uG0Lvlqxmd+7XTzATKYl4xlK96cYSmPqi4Q10OLOV0JBoN7mNTJp7QWelYjnunjYuZ
 mHkm2nhdigis1wjHiq9ctAIkfjLsv16DB63RRvCpZIwBO3yHQrByKvP2utT95qPNfE6q
 U9tnbMLNPeGMRoG29lIwuzqRto1W6+yAn2b9M+RY2PMNyAroPl3/zUxzmpM6X6UqdZer 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36kb95hp8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Feb 2021 15:24:48 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 118K55i5118354;
        Mon, 8 Feb 2021 15:24:48 -0500
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36kb95hp6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Feb 2021 15:24:47 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 118K8bsa025931;
        Mon, 8 Feb 2021 20:24:44 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 36hjch17h8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Feb 2021 20:24:44 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 118KOgGE44630474
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Feb 2021 20:24:42 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01250A4051;
        Mon,  8 Feb 2021 20:24:42 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65E2AA404D;
        Mon,  8 Feb 2021 20:24:38 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.48.239])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  8 Feb 2021 20:24:38 +0000 (GMT)
Message-ID: <158dc2d3398316edefbafdb1cfea5eca840a06e6.camel@linux.ibm.com>
Subject: Re: [PATCH 3/3] IMA: add support to measure duplicate buffer for
 critical data hook
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com,
        paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Mon, 08 Feb 2021 15:24:37 -0500
In-Reply-To: <20210130004519.25106-4-tusharsu@linux.microsoft.com>
References: <20210130004519.25106-1-tusharsu@linux.microsoft.com>
         <20210130004519.25106-4-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-08_13:2021-02-08,2021-02-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102080118
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar,

On Fri, 2021-01-29 at 16:45 -0800, Tushar Sugandhi wrote:

> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
> 
> index c096ef8945c7..fbf359495fa8 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -158,7 +158,7 @@ static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
>   */
>  int ima_add_template_entry(struct ima_template_entry *entry, int violation,
>  			   const char *op, struct inode *inode,
> -			   const unsigned char *filename)
> +			   const unsigned char *filename, bool allow_dup)
>  {
>  	u8 *digest = entry->digests[ima_hash_algo_idx].digest;
> 
 	struct tpm_digestate_entry(struct ima_template_entry *entry, int violation,
>  
>  	mutex_lock(&ima_extend_list_mutex);
>  	if (!violation) {
> -		if (ima_lookup_digest_entry(digest, entry->pcr)) {
> +		if (!allow_dup &&
> +		    ima_lookup_digest_entry(digest, entry->pcr)) {

Can't this change be simplified to "if (!violation && !allow_dup)"?

Also perhaps instead of passing another variable "allow_dup" to each of
these functions, pass a mask containing violation and allow_dup.

>  			audit_cause = "hash_exists";
>  			result = -EEXIST;
>  			goto out;

thanks,

Mimi

