Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B15A3D6054
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Jul 2021 18:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbhGZPVu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Jul 2021 11:21:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44422 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237212AbhGZPVr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Jul 2021 11:21:47 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16QFmoVJ016400;
        Mon, 26 Jul 2021 12:02:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=pQZnr1sylNnu7GcUKuXgJievW5OG0+rVT/XG1JiAJr8=;
 b=WJiqIDHXN8dkpLUMo1eBiKGhg8tfy36snEM1Z1K3DpgiPbyuzl3iz0nFPn05tbkR2KIq
 6kdzE8gTmnnzhprEqXgXGzD8dBpl26cXRMMRIaXfg/NFL/O0KhR3jXT3YMZgaXfVAkBJ
 Py6W/zjRVXMw9LSM0e1tDUjchq/oG8delbVSydPpkpUUs+5IkAvy7rrBTKRyKKGrhtvW
 wAzKpc4d9hCu2NOJ2Bge8pUZC1FC8l0OyJ5wVsh2ZQhuD+x3e9b9a3SccgolXg1WmNk9
 aaTY+Lh1UXsLJH/Vg8abxUZTEaBdrF4uwQhNbrDlqI2OgTDBU99x7JB3Kc1hbu+wupLM 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a20180jry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jul 2021 12:02:14 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16QFoe5l029364;
        Mon, 26 Jul 2021 12:02:14 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a20180jqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jul 2021 12:02:14 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16QFv54b007419;
        Mon, 26 Jul 2021 16:02:12 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3a0ag895h2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jul 2021 16:02:11 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16QG29gx26870194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 16:02:09 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 941194204C;
        Mon, 26 Jul 2021 16:02:09 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EBF142052;
        Mon, 26 Jul 2021 16:02:08 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.95.94])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 26 Jul 2021 16:02:08 +0000 (GMT)
Message-ID: <0bebaf210bc1a986c8cee9bc2fde2fee89b522b9.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/3] IMA: block writes of the security.ima xattr with
 weak hash algorithms
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Date:   Mon, 26 Jul 2021 12:02:07 -0400
In-Reply-To: <48d20c65-f208-14ee-c0bf-d84eaf3d5f67@viveris.fr>
References: <20210720092404.120172-1-simon.thoby@viveris.fr>
         <20210720092404.120172-2-simon.thoby@viveris.fr>
         <55a840fe14eac12a6e67a183c0a6155cd98beb72.camel@linux.ibm.com>
         <48d20c65-f208-14ee-c0bf-d84eaf3d5f67@viveris.fr>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nwcK5tsmgKOGWsB4alcNgspqPg8nb4dq
X-Proofpoint-ORIG-GUID: AML5F7QFpcY2Sf7MRyid9n0ggEMjrXSL
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-26_10:2021-07-26,2021-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 impostorscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 phishscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107260089
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Simon,

On Mon, 2021-07-26 at 09:49 +0000, THOBY Simon wrote:

<snip>
 
> > A new builtin policy could be defined based on the new "appraise_hash"
> > option or simply a flag (e.g. ima_policy=).
> 
> I have started to take a look at what I might do in that regard. I think your
> idea to filter writes with the ima policy is definitely better than my secure
> boot "hack". However I still wonder the form this might take to be correct.
> 
> IMHO we cannot simply consider whether there is one rule in the policy that uses the
> 'appraise_hash' option, and apply that hash algorithm policy everywhere: we do not
> want to constrain files that rule doesn't impact.
> e.g. if a rule constrains every file owned by root to be valid only if the IMA
> signature was generated with sha256, another user shouldn't be constrained by that
> rule. Consider this policy:
> appraise func=MODULE_CHECK appraise_hash=sha256
> appraise func=BPRM_CHECK fowner=0
> 
> Here we do not want to constrain xattr writes to arbitrary files because we want
> more insurances on the the kernel modules.
> This would be a behavior hard to understand for users, and probably lead to
> unexpected system breakage if someone were to upgrade their ima policy and change the
> 'appraise_hash' value, because it would apply to files that the user didn't expect
> to be impacted.
> 
> For this reason, I believe there must be a way for the setxattr hook to determine if a
> file should be affected by the hash policy or not.
> 
> At first I thought about using 'ima_get_action' in the 'ima_inode_setxattr' hook
> to extract the rule that matches the file, verify if there is a list of allowed
> hash algorithms in that rule and apply the hash restriction to the xattr being
> written.
> But then I hit a significant setback: as I understand it, IMA cannot
> detect if a given rule apply to a file *outside* of trying to executing that rule.
> Let me explain what I mean with an example. Let us suppose we have the following
> ima policy:
> appraise func=BPRM_CHECK euid=0 appraise_hash=sha1,sha256 # (1)
> appraise func=FILE_MMAP fowner=0 mask=MAY_EXEC appraise_hash=sha256,sha512 # (3)
> appraise func=FILE_MMAP euid=0 mask=MAY_EXEC appraise_hash=sha384  # (3)
> 
> (I agree that such a diversity of hashes is quite implausible on a single system
> in practice, but I also think it best to try to think of degenerate usecases
> before implementing that feature, as users will tend to rely on them)
> 
> When a user try to update the ima hash (or ima signature) of a file, how can we
> know the hash algorithms that the user can use ? How do we know if the users uses 
> a rule or another, and thus the algorithm that should apply ?
> There is no one-to-one mapping between files and rules in IMA (I understand that is not
> at all the philosophy of IMA), so the answer is "We cannot".
> Worse, two rules could both apply to the same file (e.g. he could both mmap the dynamic
> loader and run it directly, so rules (1) and (2) would both apply.
> Except they do not use the same appraise_hash parameter!
> So the step "extract the rule that matches a file" is not possible, and I need to get
> back to the drawing board.
> 
> Technically, we could try every possible combination of mask/func to determine which
> would apply to the file whose xattr is being updated, but that would be absolutely
> terrible performance wise, and it would still have bad semantics:
> - either we would choose the first rule that match, and in that case the order of the
>  policy (and the order of our exhaustive search) would impact the resulting algorithms 
>  allowed;
> - or we could consider the intersection of hash algorithms allowed in each rule
>  (it might be null) or their union (it might be overly broad and we might choose
>  an algorithm not part of the intersection, thus the will will not be usable in
>  some situations).
> 
> In short, I believe both situations would be a nightmare, for user experience,
> performance, maintainability and probable the sanity of maintainers/code reviewers.

Agreed.

> 
> I think one possible way of getting out of this conundrum would be to extend the ima
> policy further by adding a new value for the 'func' policy option (something like
> WRITE_XATTR_HASH maybe ?). In that mode, the 'mask' option would have no effect, the
> appraise_hash parameter would be mandatory, and any file matching this policy would
> have the corresponding 'appraise_hash' policy enforced.
> This might give policy rules of the following sort:
> appraise func=BPRM_CHECK euid=0 appraise_hash=sha1,sha256
> appraise func=FILE_MMAP fowner=0 mask=MAY_EXEC appraise_hash=sha256,sha512
> appraise func=FILE_MMAP euid=0 mask=MAY_EXEC appraise_hash=sha384
> appraise func=WRITE_XATTR_HASH fowner=0 obj_type=bin_t appraise_hash=sha256
> 
> The first three rules would just impact executions/mmap()s, and the last one
> would restrict xattr writes.
> 
> I agree that would add quite a bit of complexity (and a performance hit to check
> if a IMA policy matches) to the setxattr hook, that I don't see yet another way out
> of this issue.
> 
> Please let me know what you think, I certainly would prefer it if someone came up
> with a much simpler option that I could then implement.

Implementing complete setxattr policy rules, including LSM labels,
would be the safest, but as you said, it would impact performance. 
Most systems could have a simpler rule to limit the hash algorithm(s).

For example,
appraise func=SETXATTR_CHECK appraise_hash=sha256
appraise func=SETXATTR_CHECK appraise_hash=sha256,sha384,sha512

Without a SETXATTR_CHECK rule, the default would be to limit it to the
configured crypto algorithms.

(The LSM hook is named security_inode_setxattr.)

thanks,

Mimi

