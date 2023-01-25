Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C72767BFF9
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jan 2023 23:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjAYWe7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Jan 2023 17:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjAYWe6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Jan 2023 17:34:58 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D034941C
        for <linux-integrity@vger.kernel.org>; Wed, 25 Jan 2023 14:34:57 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PLwoE2021489;
        Wed, 25 Jan 2023 22:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=At/ibUiFul1pnPHZexUrIJ54VvvyfqXoEP/IHJNjDyA=;
 b=BcCXcWR87KyJBCtjlKHvlZ3jZbCtlaKQHw+U6TKdT/gSg/DZF0sPlotajMpRnsTxYh97
 tlV08OZErN/oghw9vLrXU5763LOpY4d7qN78FalL0tEnYXYRzNgOnqZwTKgJzbCbRRlQ
 qZ7L6D/B4q/kO5ddo6O3sXefoyONxUVCRlACXFgQEhzzX/360dlAdePQiHjZ7TKZNKkq
 mqKU1tm8hPHd7u53EiZPTEugnthqe2zl8SXDWkO/DhsfrEo5MviIGPP80hyWH75b8Mrx
 GIMtZh4Kw5WSc/T14AZWhmhibBjaHv2idC+EW3kAn7E2gNuCAct6tPdcrU4ptZPzo7TJ vQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nacg2381q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 22:34:49 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30PMV3oZ000624;
        Wed, 25 Jan 2023 22:34:48 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nacg2380m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 22:34:48 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PKQ1MS010736;
        Wed, 25 Jan 2023 22:34:47 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3n87p7a8te-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 22:34:47 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30PMYkla7602730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 22:34:46 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 447D75805E;
        Wed, 25 Jan 2023 22:34:46 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D074758062;
        Wed, 25 Jan 2023 22:34:45 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.18.164])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 22:34:45 +0000 (GMT)
Message-ID: <bfee27d7b5cca377f43c0e9beaf7bfefda6ec0de.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils] Experimental fsverity.test related GA CI
 improvements
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huaweicloud.com>
Date:   Wed, 25 Jan 2023 17:34:45 -0500
In-Reply-To: <20221205144447.4mtmteolbvcabzzp@altlinux.org>
References: <20221201002654.2238906-1-vt@altlinux.org>
         <7db27896916a944d8e4a212cad23865166ceb9f4.camel@linux.ibm.com>
         <20221205144447.4mtmteolbvcabzzp@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QRfMhRHBk2Q_eGDuAG-Vm76xK1JFo47Y
X-Proofpoint-GUID: Il6tuFAN8EvFVrJ1Jw7MNkXPr6jPYOY4
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_13,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250200
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Vitaly,

On Mon, 2022-12-05 at 17:44 +0300, Vitaly Chikunov wrote:
> On Mon, Dec 05, 2022 at 08:39:32AM -0500, Mimi Zohar wrote:
> > 
> > On Thu, 2022-12-01 at 03:26 +0300, Vitaly Chikunov wrote:
> > > From: Mimi Zohar <zohar@linux.ibm.com>
> > > 
> > > This does not make fsverity.test working on GA CI, though.
> > > 
> > > - `--device /dev/loop-control' is required for losetup(8) to work.
> > > - `--privileged' is required foo mount(8) to work, and this makes
> > >   `--security-opt seccomp=unconfined' redundant.
> > > - GA container does not have `/sys/kernel/security' mounted which is
> > >   needed for `/sys/kernel/security/integrity/ima/policy'.
> > > - Enable `set -x` in CI as the logs is everything we have to analyze on
> > >   failures.
> > > 
> > 
> > Agreed, even with these changes the fsverity test will not be executed,
> > but skipped.
> > 
> > However, the reason for them being skipped is totally different than
> > prior to this patch.   Once the distros have enabled both fsverity
> > support and are running a recent enough kernel with IMA support for
> > fsverity, the fsverity test should succeed.
> > 
> > So the problem isn't the GitHub actions architecture or the fsverity
> > test itself, but the lack of IMA kernel support for it.  In addition to
> > the ima-evm-utils distro tests, there needs to be a way for testing new
> > kernel integrity features.  Roberto's proposed ima-evm-utils UML patch
> > set downloads and uses a UML kernel for this purpose.
> > 
> > Unless someone can recommend a better alternative, a single UML
> > "distro" test could be defined and would be executed if a UML kernel is
> > supplied.   Additional UML tests could be specified.
> 
> Just as an idea. I did some CI testing for LKRG on GA,
>   https://github.com/lkrg-org/lkrg/blob/main/.github/workflows/docker-boot.yml
>   https://github.com/lkrg-org/lkrg/blob/main/.github/workflows/docker-boot.sh
> 
> It's possible to boot in QEMU system created in Docker (alas without
> KVM as GA does not support it). But this will install distribution's kernel.
> So it would need to find distribution with the appropriate kernel.
> 
> Also, GA have cache functionality, so there could be dependent job
> to build the kernel with required options and then save it into a cache
> (to save time, bandwidth, and CPU resources).
> 
> And another possibility is, instead of using Docker it's possible to use
> cloud images that many distributions have, and then same as with docker
> (install or build kernel, save into cache and use in next CI runs).
> Never tried this method myself. AFAIK this will require to use cloud-init
> to set up system on first boot.

Roberto's v3 "Support testing in new enviroments" patch adds the UML
support, but leaves open the option for using other environments like
virtual machines.

With the support for building a UML kernel with the appropriate Kconfig
options, the fsverity.test is now working properly.  I just posted "ci:
cleanup build.sh test log output".   With these changes, I'd appreciate
your updating this patch accordingly.

-- 
thanks,

Mimi

