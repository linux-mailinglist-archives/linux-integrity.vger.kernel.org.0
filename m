Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5103D7C89
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jul 2021 19:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhG0RrR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Jul 2021 13:47:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22874 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230090AbhG0RrP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Jul 2021 13:47:15 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16RHh0Bd130856;
        Tue, 27 Jul 2021 13:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=kVarOlfcH807wzIga43yaQWHaW1yLDTvI/618zzw2J0=;
 b=SUPD11+qJsbHHO50jXpOhqOBDuclVWEK2H2aboiB3v6XyaH2IVa4Z45n8SnC4YUiyVsd
 VQhlv58jUIY0bDEFaB1rimE61EQbWrybsUXn1P3dWy2HV7pKcq9/szh3ElGD6OCEPxlp
 oha4hI70gSvZsfhilzpLTiAEIdwj51L3Uck+tjxubflVLW1g/p0K7JDu56MaUGM90Bk6
 NK0YyPwCJttoxCGejW4EieODk4GOKFVylDJ/lkvN03oYqF7V8ML82bE06abzvj9jkwUl
 GKbpEpHHSRa2U43ySF6Ui69r8vwZ4rkqJhU8d3hAZmrx4h8Z1SHOFOIAN5N1ZagsGQuL Mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a2psp84cu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 13:47:15 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16RHhND9133277;
        Tue, 27 Jul 2021 13:47:14 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a2psp84bw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 13:47:14 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16RHT89X002655;
        Tue, 27 Jul 2021 17:47:12 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3a235m0jt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 17:47:12 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16RHlARL29360424
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 17:47:10 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6972511C054;
        Tue, 27 Jul 2021 17:47:10 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49F7411C052;
        Tue, 27 Jul 2021 17:47:09 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.85.52])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 27 Jul 2021 17:47:09 +0000 (GMT)
Message-ID: <3ee0fdf38ca04bee6b58cd043ab5fa9a99dba9c1.camel@linux.ibm.com>
Subject: Re: [PATCH v4 0/5] IMA: restrict the accepted digest algorithms for
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Date:   Tue, 27 Jul 2021 13:47:08 -0400
In-Reply-To: <20210727163330.790010-1-simon.thoby@viveris.fr>
References: <20210727163330.790010-1-simon.thoby@viveris.fr>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Z4uy4NRW1smBlGhgRfwJFktdeSU-lucL
X-Proofpoint-ORIG-GUID: Pakd2P2ZF7wxfPNKQphwQdkTFFUfMqr3
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-27_10:2021-07-27,2021-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 mlxscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107270105
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Simon,

On Tue, 2021-07-27 at 16:33 +0000, THOBY Simon wrote:
> IMA protects files by storing a hash (or a signature thereof) of their
> content in the security.ima xattr. While the security.ima xattr itself
> is protected by EVM with either a HMAC or a digital signature, no
> mechanism is currently in place to ensure that the security.ima xattr
> was generated with a strong digest algorithm, as was outlined in
> https://lore.kernel.org/linux-integrity/10dde047d76b447f32ca91356599be679b8a76e5.camel@linux.ibm.com/t/#m0f8127c6982ef94aa42f5cc13ea83b9f9000917e

Discussions should be summarized inline.  A reference to the thread
discussion may be included in a "Link" tag.  When including a "Link"
tag use the "permalink" as listed on the linux-integrity thread.  Once
the discussion is summarized, will a reference to the link really be
necessary?   Maybe fold in the subsequent paragraphs below.  Remember,
the entire cover letter or part of it, may be used as the git merge
text.

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
> 'appraise_hash=old_algo,new_algo', update the "ima_hash" parameter to
> 'new_algo', reboot, relabel all your files with 'new_algo', alter your
> policy_rule from 'appraise_hash=old_algo,new_algo' to
> 'appraise_hash=new_algo', reboot again and you're done.
> Agreed, it's quite a lot of churn - I don't know if this can be reduced -
> but this is technically doable.

Perhaps update the last line?

thanks,

Mimi

