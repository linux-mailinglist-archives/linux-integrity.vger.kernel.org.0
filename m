Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E673D8E13
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Jul 2021 14:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbhG1Mns (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Jul 2021 08:43:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14822 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234759AbhG1Mno (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Jul 2021 08:43:44 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16SCfhlX088855;
        Wed, 28 Jul 2021 08:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=NjQj5XigBA4ZJF2kKOklXCPmfwIi3CIYU7WaR7Y5lRY=;
 b=CJ8AvvIh+EhFqhlglDcHdAHYWdhdzqfYGKhT8tmLF86a06OufLD0K/PUMqq7h2hd/SRu
 dPvP053l0/SL2tnNTkU9xaVi7iw0syMV8+hr+JYwdVSF/wmcQC3NnPCoXas0YYRGKq75
 u9hsr6PIpB5BbKE3BlSPfpZY0VXiKhlEHw84T+iDbs8907xpFGVr3/agutkhyL1VSfzw
 poZRMkk0dlAL8LRop4j7IYj3u0OnfOul3nGuq7bAe3Kma51sidQrIXSBmKFEWWjMoJKB
 uGNjaqVF0dJGSiyyPwqlhiHsPq2cTxql76I+6KwVoGeDNRa9MZdEKqk9+Nnd7OcXRK6p gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a37618ed9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 08:43:40 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16SCg0ZW089874;
        Wed, 28 Jul 2021 08:43:40 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a37618eck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 08:43:39 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16SCh0Cb013164;
        Wed, 28 Jul 2021 12:43:37 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3a235m126g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 12:43:37 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16SChZbm24183144
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 12:43:35 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26846A4059;
        Wed, 28 Jul 2021 12:43:35 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7CFCA4051;
        Wed, 28 Jul 2021 12:43:33 +0000 (GMT)
Received: from sig-9-65-219-1.ibm.com (unknown [9.65.219.1])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Jul 2021 12:43:33 +0000 (GMT)
Message-ID: <3a576c8f562201f441a72bb7232c4bb0faa36318.camel@linux.ibm.com>
Subject: Re: [PATCH v4 2/5] IMA: block writes of the security.ima xattr with
 unsupported algorithms
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Cc:     Paul Moore <paul@paul-moore.com>
Date:   Wed, 28 Jul 2021 08:43:32 -0400
In-Reply-To: <529bc35e-642f-9f50-f3a7-0d3c07890afe@viveris.fr>
References: <20210727163330.790010-1-simon.thoby@viveris.fr>
         <20210727163330.790010-3-simon.thoby@viveris.fr>
         <5a3a35b5f20fb17f7430046b0378e05f1dffa098.camel@linux.ibm.com>
         <529bc35e-642f-9f50-f3a7-0d3c07890afe@viveris.fr>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JQ6Z-Kgn5NRxcOhvZrsmWnLOBrjgHWV-
X-Proofpoint-GUID: 2bDdi1ccgKAHlrLueRtWLR_4ynio5up9
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-28_07:2021-07-27,2021-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107280071
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Simon,

On Wed, 2021-07-28 at 07:00 +0000, THOBY Simon wrote: 
> >> +
> >> +	if (likely(dentry_hash == ima_hash_algo
> >> +	    || crypto_has_alg(hash_algo_name[dentry_hash], 0, 0)))
> >> +		return 0;
> >> +
> >> +	pathbuf = kmalloc(PATH_MAX, GFP_KERNEL);
> >> +	/* no memory available ? no file path for you */
> > 
> > The comment here is unnecessary.  Avoid or limit comments inside a
> > function.  Refer to the section "8) Commenting" in
> > Documentation/process/coding-style.rst
> > 
> >> +	if (pathbuf)
> >> +		path = dentry_path(dentry, pathbuf, PATH_MAX);
> >> +
> >> +	/* disallow xattr writes with algorithms not built in the kernel */
> >> +	integrity_audit_msg(AUDIT_INTEGRITY_DATA, d_inode(dentry),
> >> +		path, "collect_data", "unavailable-hash-algorithm", res, 0);
> > 
> > This will emit an audit message without the filename when !path.  Is
> > this what you intended?
> > 
> 
> This is what I was clumsily trying to explain in the previous comment: if we cannot
> allocate memory for a file path, I thought it best to log the audit message without
> the path than fail with a -ENOMEM (auditing will also try to allocate a memory buffer
> too, but a bit smaller, and memory could have been reclaimed between the two calls,
> so the auditing operation may succeed).
> 
> Of course I could also return -ENOMEM, and it would happily propagate back to the user.
> 
> What do you think ?

Memory pressure isn't the reason for preventing the xattr write.  It's
the reason for not being able to audit the setxattr failure.

thanks,

Mimi

