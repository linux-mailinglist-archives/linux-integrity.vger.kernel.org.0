Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23AD43D991E
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jul 2021 00:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhG1W4d (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Jul 2021 18:56:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48692 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232163AbhG1W4c (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Jul 2021 18:56:32 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16SMgpvr022902;
        Wed, 28 Jul 2021 18:56:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ZrH+qrBfEMExlupAAzfJuo/UvU8aK1O6Mv7dOHdGO5k=;
 b=NdmvNbQkI74oKeUR9e4sJqhiBaAM51egahFQHIHQkCtACeiq3Z+5PebQ8FMB9EmpwTi0
 n/BmDv5z0HCk6CerWy98EKKYop5XNlfoMUisFiy7alTKD6iAksNypaw/sr4aNYV6TifV
 fMqJY3bXOWGwIPdfNaycJMtgN5fSen0SNXJ9tcnWx35OJd0dgvFfjY6aD/wLM7Qswutq
 /xlZkb8zkyS8WI/p5lRVY54ISS5wZXoBkiiiur0ZKlOvX+PCyLqA8mkFtLwryBqWipCj
 0m98ngcs3izdM8jrb7e6a7bjTRr3sw49x18xKSMINx/nIDgkOZMnpllXpx/bq4NSyhLJ Kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a3fag29pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 18:56:30 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16SMuUp2090306;
        Wed, 28 Jul 2021 18:56:30 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a3fag29p0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 18:56:29 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16SMIVvg011190;
        Wed, 28 Jul 2021 22:56:27 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 3a235krva4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 22:56:27 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16SMuPZK27263408
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 22:56:25 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44F154C046;
        Wed, 28 Jul 2021 22:56:25 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C82A4C04A;
        Wed, 28 Jul 2021 22:56:24 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.118.100])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Jul 2021 22:56:23 +0000 (GMT)
Message-ID: <bc23859c8e2cfd9cd02133120fb04e9aa2590713.camel@linux.ibm.com>
Subject: Re: [PATCH v5 0/5] IMA: restrict the accepted digest algorithms for
 the security.ima xattr
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Date:   Wed, 28 Jul 2021 18:56:23 -0400
In-Reply-To: <20210728132112.258606-1-simon.thoby@viveris.fr>
References: <20210728132112.258606-1-simon.thoby@viveris.fr>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: j0fCIOUHneIwXv1rPsfWuipJK3ItyGx5
X-Proofpoint-ORIG-GUID: C1R5BzqquhORvlhGN-PU92RYTieV5pPi
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-28_12:2021-07-27,2021-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2107280115
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-07-28 at 13:21 +0000, THOBY Simon wrote:
> IMA protects files by storing a hash (or a signature thereof) of their
> content in the security.ima xattr. While the security.ima xattr itself
> is protected by EVM with either a HMAC or a digital signature, no
> mechanism is currently in place to ensure that the security.ima xattr
> was generated with a strong digest algorithm, and any hash defined
> in the kernel will be accepted, even obsolete format like MD4 and MD5.
> 
> The kernel itself will only write this xattr with the 'ima_hash' parameter,
> fixed at init, but it will also happily accept userland writes for said
> xattr, and those writes may use arbitrary hash algorithms as long as the
> kernel have support for it.
> 
> One important point is safeguarding users from mislabelling their
> files when using userland utilities to update their files, as this
> is the kind of behavior one can observe with evmctl (`evmctl ima_hash`
> defaults to sha1). Another group that may be interested is those
> that have deployed IMA years ago, possibly using algorithms that
> was then deemed sufficiently collision-resistant, but that proved
> to be weak with the passage of time (note that this could also
> happen in the future with algorithms considered safe today).
> This patch provides a migration path of sorts for these users.
> 
> This patch series gives users the ability to restrict the algorithms
> accepted by their system, both when writing/updating xattrs, and
> when appraising files, while retaining a permissive behavior by default
> to preserve backward compatibility.
> 
> To provide these features, alter the behavior of setxattr to
> only accept hashes built in the kernel, instead of any hash listed
> in the kernel (complete list crypto/hash_info.c). In addition, the
> user can define in his IMA policy the list of digest algorithms
> allowed for writing to the security.ima xattr. In that case,
> only algorithms present in that list are accepted for writing.
> 
> In addition, users may opt-in to whitelisting the hash
> algorithms accepted when appraising thanks to the new
> "appraise_hash" IMA policy option.
> By default IMA will keep accepting any hash algorithm, but specifying
> that option will make appraisal of files hashed with another algorithm
> fail.
> 
> 
> Even when using this option to restrict accepted hashes, a migration
> to a new algorithm is still possible. Suppose your policy states you
> must migrate from 'old_algo' (e.g. sha1) to 'new_algo' (e.g. one of
> sha256/384/512). You can upgrade without relaxing the hash requirements:
> alter your policy rules from 'appraise_hash=old_algo' to
> 'appraise_hash=old_algo,new_algo', load a new SETXATTR_CHECK policy
> rule that accept writes using 'new_algo', reboot, relabel
> all your files with 'new_algo', alter your policy rules from
> 'appraise_hash=old_algo,new_algo' to 'appraise_hash=new_algo',
> and you're done.
> While this represent a significant amount of work, it is important to
> showcase that this patchset is flexible enough to let users upgrade
> if needed.
> 
> 
> This series is based on the following repo/branch:
>  repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>  branch: master
>  commit ff1176468d368232b684f75e82563369208bc371 ("Linux 5.14-rc3")

A few high level comments:

- I recently accepted a couple of patches, which are now in the next-
integrity-testing branch.  When reposting, please rebase this patch set
on top of it.

- The code uses the term "allowed lists", not "white lists", but the
cover letter, patch descriptions, and/or comments still refer to "white
lists".  For an explanation refer to the new section "Naming" in
Documentation/process/coding-style.rst.

- There was some discussion about allowing code longer than 80 columns,
but the section on  "Breaking long lines and strings" in
Documentation/process/coding-style.rst hasn't been updated.  Please
make sure that the new code has a max line length of 80.

thanks,

Mimi

