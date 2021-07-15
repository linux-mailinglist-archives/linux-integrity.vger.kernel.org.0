Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65EC33C9E93
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Jul 2021 14:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237199AbhGOM3b (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Jul 2021 08:29:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21166 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230031AbhGOM3b (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Jul 2021 08:29:31 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16FC3ck7014412;
        Thu, 15 Jul 2021 08:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=PyhA4SYWmWzBS/VyD7937v+6nJUNghL3IFVicM8Uw00=;
 b=IvKZVzlGYH+fHylUhGNMFZt5D6s7S9F5+FD5345ErXfnUH/CQ7HRhuML6/rXAc9D21km
 75Uc6dpP4JGFvDxSSYnNQIZltv54w3MpBs7m0je/FleVgAKOaop/E1TLO0Id/7tG9iaY
 Yr2Z1QSa0ZVvVK9A51500RCoGWzfgIa/81d/EWeojztFT7RnQOvuvh+HhzGAuRkJycoh
 8xtwPXoSJSVsknq7T2DvQSriQU/Oo/RoFTX7O11eiT1BiXqlI5DFqNGXIsdfmzYvgRrn
 2tVwyo/7LAENJh1CDF61s65R/0AaKKPAGw4LU65+dioMCaWbOZEVAiyWCUDkb5AEO0sb Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39tbj6ejkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jul 2021 08:26:37 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16FC3deE014589;
        Thu, 15 Jul 2021 08:26:37 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39tbj6ejkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jul 2021 08:26:37 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16FCEPqF016304;
        Thu, 15 Jul 2021 12:26:35 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 39q2tha8ys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jul 2021 12:26:35 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16FCONAR36176274
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jul 2021 12:24:23 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5077B42082;
        Thu, 15 Jul 2021 12:26:33 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34EFB4208A;
        Thu, 15 Jul 2021 12:26:32 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.117.215])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 15 Jul 2021 12:26:32 +0000 (GMT)
Message-ID: <5dd1cc267f4b820c115e85210e1137c73c4e2562.camel@linux.ibm.com>
Subject: Re: [PATCH] IMA: add an option to restrict the accepted hash
 algorithms
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Date:   Thu, 15 Jul 2021 08:26:31 -0400
In-Reply-To: <1fcf5b7f-00bc-7963-cb9e-c7e7e8278c9b@viveris.fr>
References: <1fcf5b7f-00bc-7963-cb9e-c7e7e8278c9b@viveris.fr>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kK3IdWbv2xsFC52sUUEi1172wJnHIMk1
X-Proofpoint-ORIG-GUID: ljSV34W-d78zXp8TTdKGLql7YVUc0QVF
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-15_07:2021-07-14,2021-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 spamscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107150088
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Simon,

On Tue, 2021-07-13 at 14:48 +0000, THOBY Simon wrote:
> Sorry it took me some time before I could write a patch (in addition it's my
> first kernel contribution so I'm still learning how things should be done, like
> fighting Outlook on the web, giving up on it and moving to Mozilla Thunderbird).

Thanks!

> 
> This patch is a follow up on the discussion at
> https://lore.kernel.org/linux-integrity/10dde047d76b447f32ca91356599be679b8a76e5.camel@linux.ibm.com/t/#m0f8127c6982ef94aa42f5cc13ea83b9f9000917e.
> 
> 
> This patch was built on top of linux-5.14.0-rc1, and I successfully tested the patch
> in the following configurations:
> - disabled: no visible impact (as expected)
> - with ima_allowed_hashes=sha256,sha512:
> 	- alone: blocks both execution and xattr writes
> 	  (tested with `emvctl ima_hash -a md5 <my binary>`)
> 	- with ima_appraise=log: audit logs but still permits access
> 	- with ima_appraise=fix: audit logs but still permits access, however it
> 	  doesn't fix the hash (so maybe I should do something about it, because
> 	  right now it's basically the same as ima_appraise=log w.r.t. hash
> 	  algorithms ?)
> 	- with ima_accept_any_hash: permits access, no warnings whatsoever
> Do you want ideas of other configurations that I could test?
> 
> I would also like to point out that I'm more than open to suggestions for
> changing the names of the parameters (`ima_allowed_hashes` and
> `ima_accept_any_hash`) and the "cause" in the audit log (currently 
> forbidden-hash-algorithm"), because as you know, "naming things is hard".
> 
> 
> IMA: add an option to restrict the accepted hash algorithms
> 
> Adds two command-line parameters to limit the hash algorithms
> allowed for the security.ima xattr. 

Having two boot command line paramaters is a good indication that this
patch needs to be broken up.  Please refer to the section "Separate
your changes" in Documentation/process/submitting-patches.rst.  The
cover letter provides the motivation for the patch set.

> This gives users the
> ability to ensure their systems will not accept weak hashes,
> and potentially increase users trust in their IMA configuration,
> because they can ensure only strong collision-resistant hashes
> are employed and files generated otherwise will not be accepted.

Boot command line options should be minimized as much as possible. 
Perhaps without defining new kernel boot paramaters there are some
additional checks that could be added.  For example, on a FIPS enabled
system, prevent writing non FIPS allowed file signatures, limit file
signature algorithms to those enabled on the system, define new policy
rules to limit the permitted hash algorithms.

thanks,

Mimi

> 
> The main point is to safeguard users from mislabelling their files
> when using userland utilities to update their files, e.g. evmctl
> (`evmctl ima_hash` defaults to sha1). Another possible target
> would be people that have deployed IMA years ago, possibly using
> algorithms that was then deemed sufficiently collision-resistant,
> but that proved to be weak with the passage of time (note that this
> could also happen in the future with algorithms considered safe today).
> This patch also provides a migration path for users.

> 
> The first parameter supplies a list of allowed algorithms to
> the kernel, restricting appraisal to files hashed with "strong"
> hash algorithms (by default IMA will keep accepting any hash
> algorithm, as enabling such a feature by default would both be
> backward-incompatible and very probably break real systems).
> The second parameter is an escape hatch that adds a weaker form
> of backward-compatibility: when activated, IMA apparaisal will
> keep working on files hashed with an algorithm not present in
> the list, but updates to these files or new writes to the security.ima
> xattr will enforce the selected hash algorithms. This may be useful
> to perform an online migration from one algorithm to another.
> 
> 
> Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>

