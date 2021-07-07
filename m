Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980583BE9DC
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 16:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbhGGOkK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Jul 2021 10:40:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38768 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231737AbhGGOkK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Jul 2021 10:40:10 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 167EX3Ik097111;
        Wed, 7 Jul 2021 10:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=MbAQoCSurBvBkfEEhxCTzibngU7eVOsxFjyc1DpZBl8=;
 b=BsujSTiYImw1cHj0emma9sOIlOHyscoBD/JF8TTgXw5QLhRQVhYvtdOv00KIFHBpAZG9
 8lRjIiDzBzsGlgIL3Fe/78fUjJA7EVmkMYpCpT8/zuQW3QDD/zG3QWLdVPFkLxbvUn7m
 8rlxuHmC2Ol1ggQdi22gZsbWyHSLSRDnaxrL12v3ZIl8WJfsshMRt30qNqiZnkxixUdt
 vCkLsW5dxGkRz3Rek4daCbK/YXLhMmCbQj93iW/Zef0yytO5aLuLHLGUf345HCC/uo1L
 Hf6vUaDvUZaMRUREpIF4M8GzazEAGjuhDM08pE8Y7YUhviaQPCIIhBfWmaYJvWAEoTVN 5Q== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39nc7xbtdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jul 2021 10:37:30 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 167EYqNJ009125;
        Wed, 7 Jul 2021 14:37:28 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 39jf5h9t2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jul 2021 14:37:27 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 167EZXKZ32178560
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Jul 2021 14:35:33 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96C1FAE04D;
        Wed,  7 Jul 2021 14:37:25 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF6E8AE056;
        Wed,  7 Jul 2021 14:37:24 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.79.186])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  7 Jul 2021 14:37:24 +0000 (GMT)
Message-ID: <96afb16f1f9ac6a476b8fb7be988f90267837c6c.camel@linux.ibm.com>
Subject: Re: Weak hash algorithms allowed with DIGEST_NG
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Date:   Wed, 07 Jul 2021 10:37:24 -0400
In-Reply-To: <AM4PR0902MB1748D83387C6F3D39C98992F941A9@AM4PR0902MB1748.eurprd09.prod.outlook.com>
References: <AM4PR0902MB1748D83387C6F3D39C98992F941A9@AM4PR0902MB1748.eurprd09.prod.outlook.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tWDekVZoaiCpHA1qcI_6ipkC7GNG-UsS
X-Proofpoint-ORIG-GUID: tWDekVZoaiCpHA1qcI_6ipkC7GNG-UsS
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-07_08:2021-07-06,2021-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107070086
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Simon,

On Wed, 2021-07-07 at 09:54 +0000, THOBY Simon wrote:

<snip>

> When using evmctl and IMA-EVM in hash+HMAC mode (no digital
> signatures involved), I was suprised to see that IMA didn't complain
> if a file was hashed with an algorithm "weaker" than the one
> specified on the command line.
> Of course I suppose EVM should stop downgrade attacks (by that I mean
> an offline attacker changing the hash of a legitimate file from
> sha256 to sha1 or md5). However, if files were already hashed as md5
> - or more probably sha1 because that is still the default value for
> evmctl - then the attacker could potentially perform collision
> attacks against the weakly hashed file. The user may believe himself
> protected against collision attacks because of the 'ima_hash=sha256'
> command line parameter (with or without 'ima_template=ima-ng').

Before allowing the EVM HMAC to be updated, EVM verifies the existing
HMAC to protect against an offline attack.  It doesn't prevent online
changes.  Additional support to prevent crypto downgrade would need to
be added.

<snip>

> Is there any way to enforce the use of the hash specified in the
> 'ima_hash' cmdline parameter ?

The cmdline parameter overrides the compile time default hash algorithm
used for (re-)calculating the file hash.

> I couldn't find any glancing at the code, but I didn't read all of it
> and I understood even less, so I secretly hope to have missed a small
> yet critical check/option.
> And if there is no such way, would you be opposed to a patch adding
> an option (something like 'ima_enforce_hash_alg') that only allows
> digest hashed with the values supplied in the 'ima_hash' parameter ?

Please keep in mind that:
- depending on which file is not properly signed with the required
hash, the system might not boot.
- limiting the hash algorithm to a single algorithm would prevent
migrating to a stronger algorithm.

For embedded/IoT, these concerns might not be a problem.

thanks,

Mimi

