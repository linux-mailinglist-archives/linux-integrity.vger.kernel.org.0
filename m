Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9D13EDFE2
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Aug 2021 00:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbhHPWVG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Aug 2021 18:21:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52244 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234391AbhHPWVG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Aug 2021 18:21:06 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17GM4XZd120528;
        Mon, 16 Aug 2021 18:20:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=kIX9EVrXGERnPUvPGe7vhmzFhozHU85C64p7/aDycAY=;
 b=ojGuFaw9bRZgVo4la9DrQn4HFP5tampJznCZ61b/iFuVsukSetYxCPO75G4r61baQfob
 H86kxkazBRWS+Dlhwsa/eDVTlOVwJpf/ZSWsu/NbJ+w5U4RJvHbecmVdTFSICbbXUFUk
 9pDqlAcAEzoMLHBmo9g47rzW1503fh9/ff1+GIgjTgwDOUSNwoLQeCrFgzcmWceOQ8kP
 P7oTpowC94601qGNxXc0CR2mMHIM5rdzbDBmyzi7NtWm178PogPLkYUI9s2heIqc5bEH
 NAU6LG3hreUWxIBrQK3SJHn9kSopcaoChBzcNcxCsJjRBw3wdyINkqlwQz7DaJR/uKr3 Xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3aeuct5a1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Aug 2021 18:20:33 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17GM4n2d121545;
        Mon, 16 Aug 2021 18:20:33 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3aeuct5a17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Aug 2021 18:20:33 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17GMI4Rj026049;
        Mon, 16 Aug 2021 22:20:31 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3ae5f8bwmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Aug 2021 22:20:31 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17GMH5Rs60293404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 22:17:05 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2FBB52054;
        Mon, 16 Aug 2021 22:20:28 +0000 (GMT)
Received: from sig-9-65-222-129.ibm.com (unknown [9.65.222.129])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A088552050;
        Mon, 16 Aug 2021 22:20:27 +0000 (GMT)
Message-ID: <aa0c635a090ff6849c4334566d6721ee036c491f.camel@linux.ibm.com>
Subject: Re: [PATCH v8 6/6] IMA: prevent SETXATTR_CHECK policy rules with
 unavailable algorithms
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Date:   Mon, 16 Aug 2021 18:20:26 -0400
In-Reply-To: <20210816081056.24530-7-Simon.THOBY@viveris.fr>
References: <20210816081056.24530-1-Simon.THOBY@viveris.fr>
         <20210816081056.24530-7-Simon.THOBY@viveris.fr>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RgkKlKHR9H05C2r5n6y-rUpSvVjZ6eKa
X-Proofpoint-GUID: ddRw2cX-0comQLsrRHetDTclhNOeeTj_
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-16_08:2021-08-16,2021-08-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108160138
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-08-16 at 08:11 +0000, THOBY Simon wrote:
> SETXATTR_CHECK poliy rules assume that any algorithm listed in the
> 'appraise_algos' flag must be accepted when performing setxattr()
> on the security.ima xattr.
> However nothing checks that they are available in the current kernel.
> A userland application could hash a file with a digest that the kernel
> wouldn't be able to verify. However, if SETXATTR_CHECK is not in use,
> the kernel already forbids that xattr write.

I assume the above couple of sentences are a continuation of the
previous paragraph and concatenated them.  If it really is meant to be
a separate paragraph a blank line needs to separate them.

> 
> Verify that algorithms listed in appraise_algos are available to the
> current kernel and reject the policy update otherwise. This will fix
> the inconsistency between SETXATTR_CHECK and non-SETXATTR_CHECK
> behaviors.
> 
> That filtering is only performed in ima_parse_appraise_algos() when
> updating policies so that we do not have to pay the price of allocating
> a hash object every time validate_hash_algo() is called in
> ima_inode_setxattr().
> 
> Signed-off-by: THOBY Simon <Simon.THOBY@viveris.fr>

Thanks, Simon.  Before pushing out the entire patch set, including this
one, to next-integrity-testing branch,  I reverted the tag re-ordering, 
fixed the line length of the sample appraise rule, and added the commit
number (for stable) in the patch description.  Please verify.

While testing, I noticed similar support is needed for appended
signatures.  For example, "scripts/sign-file" can be used to sign
kernel modules or the kernel image.

Sample kexec rules:
measure func=KEXEC_KERNEL_CHECK template=ima-modsig
appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig appraise_algos=sha256

thanks,

Mimi



