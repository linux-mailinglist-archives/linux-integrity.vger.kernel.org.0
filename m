Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D3F6988B5
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Feb 2023 00:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjBOXTm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Feb 2023 18:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBOXTl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Feb 2023 18:19:41 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F038B42BE2
        for <linux-integrity@vger.kernel.org>; Wed, 15 Feb 2023 15:19:40 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31FMiBut031102;
        Wed, 15 Feb 2023 23:19:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Mn4mDJg4oAf0yM1NquYW+IBcSgU3w2Q34B1ymq8YKF0=;
 b=JjkwoWNvc0WliXqrrAhiXteKY4PyO/jViOo9a05n3MIdSiG6nOi7d2O1Ey5QCRTD58jV
 OSIpJaC/PU/jb3AxMxoK7HwJJmzCdzimJR+BgVli4AFKCduNMLZYuy9Tf0bSrps5i4FB
 Sp0hUpdemv906KidlqM8ceBCg2c0zwdAcIcwyhqFc/gBND7YIFlU8AFQ5wjzsD3Mi/lD
 hmE+twG3vhiOZvKGqwJY4MdZ251d/qptoTov3K1ieYtGvOK4bknpyL7ZFptKxeJxQZoL
 QCwDq8aBpJt8Nq9S/skfWkP6uPfEl4TT5qgxGSXIZhyXuF0I42lhNYWgm2T47fiOf5ER Tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ns8eq0km6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 23:19:27 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31FMq39F021777;
        Wed, 15 Feb 2023 23:19:26 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ns8eq0km2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 23:19:26 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31FM1QLs000913;
        Wed, 15 Feb 2023 23:19:25 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([9.208.129.118])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3np2n7nf5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 23:19:25 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31FNJO6B27984380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 23:19:24 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67CB758053;
        Wed, 15 Feb 2023 23:19:24 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A81B158043;
        Wed, 15 Feb 2023 23:19:23 +0000 (GMT)
Received: from sig-9-65-193-223.ibm.com (unknown [9.65.193.223])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 15 Feb 2023 23:19:23 +0000 (GMT)
Message-ID: <8c65e64026e33caf6cf756c616f3effe249cae4b.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils 0/3] CI: Tumbleweed openSSL fix
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Cc:     dmitry.kasatkin@gmail.com, vt@altlinux.org, stefanb@linux.ibm.com
Date:   Wed, 15 Feb 2023 18:19:23 -0500
In-Reply-To: <Y+1gTC0cjCo6Aw0v@pevik>
References: <20230214210035.585395-1-pvorel@suse.cz>
         <Y+1gTC0cjCo6Aw0v@pevik>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: anU-WI1Qn4LnAtIsAPue_iyEyzSU79bs
X-Proofpoint-ORIG-GUID: 81SUPNdRRg7J52ZaRAQHQ-3_AMy1VLam
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_13,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015
 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302150197
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,

On Wed, 2023-02-15 at 23:44 +0100, Petr Vorel wrote:
> Hi Mimi,
> 
> > Tested:
> > https://github.com/pevik/ima-evm-utils/actions/runs/4177976359/jobs/7236222413
> 
> Thanks for merging this.

I actually pushed out the patches to "next-testing" to make sure it
works.  In doing so, I dropped a couple of Roberto's patches, which
aren't quite ready and one of mine as well.  In general, I'm not sure
pushing patches out to "next-integrity" should be considered "merging"
quite yet.  In this case, your patches are fine.  (Perhaps there needs
to be a better work flow.)

> 
> My test was working:
> https://github.com/pevik/ima-evm-utils/actions/runs/4177976359

Yes, I saw.

> 
> But the same code now fails for Fedora.
> I wonder what exactly is wrong now:
> https://github.com/mimizohar/ima-evm-utils/actions/runs/4188686859/jobs/7260231106
> https://github.com/pevik/ima-evm-utils/actions/runs/4188761663/jobs/7260289846

The UML kernel built properly, but for some reason the fsverity and
portable_signature tests aren't finding it.

> 
> FAIL: fsverity
> ==============
> 
> which: no fsverity in (../src:../fsverity-utils:/github/home/ima-evm-utils-install/bin:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin)
> dd is /usr/bin/dd
> mkfs is /usr/sbin/mkfs
> blkid is /usr/sbin/blkid
> e2fsck is /usr/sbin/e2fsck
> tune2fs is /usr/sbin/tune2fs
> evmctl is ../src/evmctl
> setfattr is /usr/bin/setfattr
> ./functions.sh: line 90: ../linux: No such file or directory
> =================================
>  Run with FAILEARLY=1 ./fsverity.test _cleanup_env cleanup
>  To stop after first failure
> =================================
> PASS: 0 SKIP: 0 FAIL: 1
> 
> FAIL fsverity.test (exit status: 1)
> 
> FAIL: portable_signatures
> =========================
> 
> evmctl is /__w/ima-evm-utils/ima-evm-utils/tests/../src/evmctl
> ./functions.sh: line 90: ../linux: No such file or directory
> ./functions.sh: line 90: ../linux: No such file or directory

-- 
Mimi

