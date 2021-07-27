Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20AC3D79CD
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jul 2021 17:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237078AbhG0P3l (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Jul 2021 11:29:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48386 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232643AbhG0P3e (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Jul 2021 11:29:34 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16RF86Au090214;
        Tue, 27 Jul 2021 11:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=9m6JdoEMB+8iKU/wHGW/PAOtNPZdOO7HOkI3QqPRUFk=;
 b=A2PzOM1cJrH2NSRwV0Az1jwcRxs0MWRsB9qjP5EsJl7/yuANpQ8dyB5kML3FQKjgWsE4
 715aSIhbD6LKl4Rbea/vwfyTeWuyc0cZQZHTMyRfKXsnJ79GO/2mo214eB0HSrz2C+Gg
 Bt6lgb/ggEYlMSlCC+13qhrn+6NsD19t45M3TfIPK+FiCx7AZTdeu/U6BzvNSlKfyrWg
 i7ekmJfs9+eO7Zj3W+LQM85D0Pi6Yb81rLnhWHIA57zV8U98XL3un8ADx2c+iRrV8tcC
 zbE77Yn228JgbTxylnkyOxZaUfOPPx1/CgXKw4/oYTKUB6bygHWDCkwK4NZdLrD5WvZi aA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a2m5g22b1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 11:29:34 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16RF9Wbj101949;
        Tue, 27 Jul 2021 11:29:34 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a2m5g22a7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 11:29:34 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16RFQteI000893;
        Tue, 27 Jul 2021 15:29:31 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 3a235kgb73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 15:29:31 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16RFTT6E18219312
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 15:29:29 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0AA0CA4051;
        Tue, 27 Jul 2021 15:29:29 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B690CA4055;
        Tue, 27 Jul 2021 15:29:27 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.85.52])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 27 Jul 2021 15:29:27 +0000 (GMT)
Message-ID: <1664c5d77e148eb387717428c55d2ef4f2482732.camel@linux.ibm.com>
Subject: Re: [PATCH v3 2/4] IMA: add support to restrict the hash algorithms
 used for file appraisal
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Date:   Tue, 27 Jul 2021 11:29:26 -0400
In-Reply-To: <20210727102307.552052-3-simon.thoby@viveris.fr>
References: <20210727102307.552052-1-simon.thoby@viveris.fr>
         <20210727102307.552052-3-simon.thoby@viveris.fr>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6ISpMEn49DhtqsK8SQNgIPQKIVqSOz2b
X-Proofpoint-GUID: 6sfv_TSMgTV_Dm12v8aPvfGen1d6VITD
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-27_10:2021-07-27,2021-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107270090
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Simon,

On Tue, 2021-07-27 at 10:23 +0000, THOBY Simon wrote:
> This patch plugs in support for restricting the hash algorithms
> accepted for protecting the security.ima xattr when appraising
> files.

The first sentence should provide the motivation for the patch.  For
example, start this paragraph by saying that the hash algorithms are
currently not restricted.  Then continue with "Restrict ..." or maybe
"Provide the plumbing to restrict ...".

> 
> Each ima policy rule can have a list of allowed hash algorithms,
> and a file matching the policy but whose IMA hash is
> not explicitly in the list will not pass appraisal.

Belongs in the patch associated with the IMA policy "appraise_hash"
rule option.
> 
> This do not apply only to IMA in hash mode, it also works with digital
> signatures, in which case it checks that the hash (which was then
> signed by the trusted private key) have been generated with one of
> the algortihms whitelisted for this specific rule.

Instead of phrasing this paragraph in the negative, the content could
be combined with the first paragraph in the positive.   For example,
"Restrict the permitted set of hash algorithms used for verifying file
signatures stored in security.ima xattr."

> 
> Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
> ---

<snip>

> @@ -327,6 +329,20 @@ static int process_measurement(struct file *file, const struct cred *cred,
>  
>  	hash_algo = ima_get_hash_algo(xattr_value, xattr_len);
>  
> +	/* Ensure that the digest was generated using an allowed algorithm */
> +	if (appraisal_allowed_hashes &&
> +	    !(appraisal_allowed_hashes & (1U << hash_algo))) {
> +		rc = -EACCES;
> +
> +		if (!pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
> +			pathname = ima_d_path(&file->f_path, &pathbuf, filename);
> +
> +		integrity_audit_msg(AUDIT_INTEGRITY_DATA, file_inode(file),
> +			pathname, "collect_data", "forbidden-hash-algorithm", rc, 0);
> +
> +		goto out_locked;
> +	}
> +

This doesn't look like the right place for checking the hash algorithm.
IMA may be configured differently on different systems.  Some might
only enable measurement without appraisal, appraisal without
measurement, or both.  Only appraisal returns a failure and prevents
read, execute, mmap, etc.   The hash algorithm check probably should be
deferred to appraisal.  Placing the test here would skip measurements.

thanks,

Mimi

>  	rc = ima_collect_measurement(iint, file, buf, size, hash_algo, modsig);
>  	if (rc != 0 && rc != -EBADF && rc != -EINVAL)
>  		goto out_locked;


