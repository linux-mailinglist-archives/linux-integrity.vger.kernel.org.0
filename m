Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1C96998E2
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Feb 2023 16:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjBPPaS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Feb 2023 10:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjBPPaR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Feb 2023 10:30:17 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BA01EBDE
        for <linux-integrity@vger.kernel.org>; Thu, 16 Feb 2023 07:30:16 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31GEMjCa033700;
        Thu, 16 Feb 2023 15:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=TUe0P5cgHVD8t3pZ5YG5j2ur1dyM7Luo6oOAL/Vm2+8=;
 b=a09tzVo5+mz7BkbOSOgsdIvkNALt08C4JTwgjanjsu+i/uV8540E85eL0DQHqvoWqVBX
 ieHFElEyGekWkOZjW1SNeESohy7x2Ei0abYVX7qRibIIt7TK2aonHVmlwAdLlkiDdhFe
 zi6TvvAdPnfuPrJaFEKMPKw+UUJUsXPvF2v82tiNiPJyv0G7YYX5MENlqFO0ySspHFTU
 zFVNlEAdjw08Z+xqe4N7ri6nEzbehBV9H/NG1w4rAk5EmTPb2yblUjxmQQx8DShecONd
 AfyA4RpC6MJQHpc++ujKFhyHu1EtERL/S410Sx28/TIBNdhCiMExxarK619qfKu1WOyD KA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nsp6v1u1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 15:29:56 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31GEPEOV003238;
        Thu, 16 Feb 2023 15:29:56 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nsp6v1u0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 15:29:55 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31GCLD7Q016681;
        Thu, 16 Feb 2023 15:29:54 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3np2n7k69y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 15:29:54 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31GFTrYw37028548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Feb 2023 15:29:53 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E4E558054;
        Thu, 16 Feb 2023 15:29:53 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99BF658055;
        Thu, 16 Feb 2023 15:29:52 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.163.119])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 16 Feb 2023 15:29:52 +0000 (GMT)
Message-ID: <237824c946ab55dd14fc39d4e34cd73a0d620cb3.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils 0/3] CI: Tumbleweed openSSL fix
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Cc:     dmitry.kasatkin@gmail.com, vt@altlinux.org, stefanb@linux.ibm.com
Date:   Thu, 16 Feb 2023 10:29:52 -0500
In-Reply-To: <006bceba21b205f862d92a50c7095397f30d1b9e.camel@huaweicloud.com>
References: <20230214210035.585395-1-pvorel@suse.cz>
         <Y+1gTC0cjCo6Aw0v@pevik>
         <8c65e64026e33caf6cf756c616f3effe249cae4b.camel@linux.ibm.com>
         <006bceba21b205f862d92a50c7095397f30d1b9e.camel@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YGddsoDJSB2sk2lMWeKkVQcZGeOMmGoI
X-Proofpoint-ORIG-GUID: xihcdO2Zvaa2NmJF02c8LNFOqnejbLOk
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_11,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 lowpriorityscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302160130
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-02-16 at 09:16 +0100, Roberto Sassu wrote:
> On Wed, 2023-02-15 at 18:19 -0500, Mimi Zohar wrote:
> > Hi Petr,
> > 
> > On Wed, 2023-02-15 at 23:44 +0100, Petr Vorel wrote:
> > > Hi Mimi,
> > > 
> > > > Tested:
> > > > https://github.com/pevik/ima-evm-utils/actions/runs/4177976359/jobs/7236222413
> > > 
> > > Thanks for merging this.
> > 
> > I actually pushed out the patches to "next-testing" to make sure it
> > works.  In doing so, I dropped a couple of Roberto's patches, which
> > aren't quite ready and one of mine as well.  In general, I'm not sure
> > pushing patches out to "next-integrity" should be considered "merging"
> > quite yet.  In this case, your patches are fine.  (Perhaps there needs
> > to be a better work flow.)
> > 
> > > My test was working:
> > > https://github.com/pevik/ima-evm-utils/actions/runs/4177976359
> > 
> > Yes, I saw.
> > 
> > > But the same code now fails for Fedora.
> > > I wonder what exactly is wrong now:
> > > https://github.com/mimizohar/ima-evm-utils/actions/runs/4188686859/jobs/7260231106
> > > https://github.com/pevik/ima-evm-utils/actions/runs/4188761663/jobs/7260289846
> > 
> > The UML kernel built properly, but for some reason the fsverity and
> > portable_signature tests aren't finding it.
> 
> It could be this (in the logs):
> 
> There exist one or more cache(s) with similar key but they have
> different version or scope.
> 
> I would try:
> 
> enableCrossOsArchive: true
> 
> after:
> 
>       uses: actions/cache@v3
>       with:
>         path:
>         key:
> 
> for every step using the cache.
> 
> Cache version is a hash generated for a combination of compression tool
> used (Gzip, Zstd, etc. based on the runner OS) and the path of
> directories being cached.
> 
> Maybe there was some change from the time the kernel and signing key
> were cached.

Adding "enableCrossOsArchive: true" didn't help, nor did clearing the
cache.

Mimi


> 
> > > FAIL: fsverity
> > > ==============
> > > 
> > > which: no fsverity in (../src:../fsverity-utils:/github/home/ima-evm-utils-install/bin:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin)
> > > dd is /usr/bin/dd
> > > mkfs is /usr/sbin/mkfs
> > > blkid is /usr/sbin/blkid
> > > e2fsck is /usr/sbin/e2fsck
> > > tune2fs is /usr/sbin/tune2fs
> > > evmctl is ../src/evmctl
> > > setfattr is /usr/bin/setfattr
> > > ./functions.sh: line 90: ../linux: No such file or directory
> > > =================================
> > >  Run with FAILEARLY=1 ./fsverity.test _cleanup_env cleanup
> > >  To stop after first failure
> > > =================================
> > > PASS: 0 SKIP: 0 FAIL: 1
> > > 
> > > FAIL fsverity.test (exit status: 1)
> > > 
> > > FAIL: portable_signatures
> > > =========================
> > > 
> > > evmctl is /__w/ima-evm-utils/ima-evm-utils/tests/../src/evmctl
> > > ./functions.sh: line 90: ../linux: No such file or directory
> > > ./functions.sh: line 90: ../linux: No such file or directory
> 


