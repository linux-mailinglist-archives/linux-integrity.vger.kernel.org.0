Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E134369CBDF
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Feb 2023 14:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjBTNST (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Feb 2023 08:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjBTNSS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Feb 2023 08:18:18 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45334C17E
        for <linux-integrity@vger.kernel.org>; Mon, 20 Feb 2023 05:18:16 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31KCre9d027446;
        Mon, 20 Feb 2023 13:18:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=8uPTX4v3LRuaaQvPtwDgAXdyDznOMdTcgGwGk03NCq4=;
 b=UxDYrqLkuu/k0CnToINRyvTgnFpFTx/+v0Cw5JxpkXYgDFxzCJebWIUu5GbgKPQXvvse
 yrT7vxwyv91a0X9i4Mf5ivKgaoMPDFBT4hQZMVDdqCeD8DQXZKZxKxXtwgsMVlplb2pu
 ln8GoSALUp2Adl5Je6PNtkJqjTqbDOmMBzUDmVu2CKekNvivKhb/jc94NGQ/igySSJ9Y
 nhGjLVMIT/nOD0gjEhlCJARSdi0X9oV7owAKn5Pzu1zYpyhozJACzen2Kjzp7gx0jG0r
 pNJozSDzbDoc0erTq04nJhs6ayKQ9Qx1vzeTiWiuT7R7SxdjC/mYDq7tUaXqL+ri4py5 sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nv6yhbu6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 13:18:00 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31KCUVtZ027552;
        Mon, 20 Feb 2023 13:17:59 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nv6yhbu5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 13:17:59 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31KCQSaB027865;
        Mon, 20 Feb 2023 13:17:58 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3ntpa75cb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 13:17:58 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31KDHv393605026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Feb 2023 13:17:57 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15A505805E;
        Mon, 20 Feb 2023 13:17:57 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3DFD95805D;
        Mon, 20 Feb 2023 13:17:56 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.169.160])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Feb 2023 13:17:56 +0000 (GMT)
Message-ID: <3f3d8d134a33f05405c1b814c8a61b5bd0411e4b.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils 0/3] CI: Tumbleweed openSSL fix
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Cc:     dmitry.kasatkin@gmail.com, vt@altlinux.org, stefanb@linux.ibm.com
Date:   Mon, 20 Feb 2023 08:17:55 -0500
In-Reply-To: <237824c946ab55dd14fc39d4e34cd73a0d620cb3.camel@linux.ibm.com>
References: <20230214210035.585395-1-pvorel@suse.cz>
         <Y+1gTC0cjCo6Aw0v@pevik>
         <8c65e64026e33caf6cf756c616f3effe249cae4b.camel@linux.ibm.com>
         <006bceba21b205f862d92a50c7095397f30d1b9e.camel@huaweicloud.com>
         <237824c946ab55dd14fc39d4e34cd73a0d620cb3.camel@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YcpWiT4D-tL7PYt2TvylVKQKpRNKhpmx
X-Proofpoint-ORIG-GUID: nstwuZG0h9fYvTxb2zIRDWeGbdfWLVl9
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_10,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 impostorscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302200119
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-02-16 at 10:29 -0500, Mimi Zohar wrote:
> On Thu, 2023-02-16 at 09:16 +0100, Roberto Sassu wrote:
> > On Wed, 2023-02-15 at 18:19 -0500, Mimi Zohar wrote:
> > > Hi Petr,
> > > 
> > > On Wed, 2023-02-15 at 23:44 +0100, Petr Vorel wrote:
> > > > Hi Mimi,
> > > > 
> > > > > Tested:
> > > > > https://github.com/pevik/ima-evm-utils/actions/runs/4177976359/jobs/7236222413
> > > > 
> > > > Thanks for merging this.
> > > 
> > > I actually pushed out the patches to "next-testing" to make sure it
> > > works.  In doing so, I dropped a couple of Roberto's patches, which
> > > aren't quite ready and one of mine as well.  In general, I'm not sure
> > > pushing patches out to "next-integrity" should be considered "merging"
> > > quite yet.  In this case, your patches are fine.  (Perhaps there needs
> > > to be a better work flow.)
> > > 
> > > > My test was working:
> > > > https://github.com/pevik/ima-evm-utils/actions/runs/4177976359
> > > 
> > > Yes, I saw.
> > > 
> > > > But the same code now fails for Fedora.
> > > > I wonder what exactly is wrong now:
> > > > https://github.com/mimizohar/ima-evm-utils/actions/runs/4188686859/jobs/7260231106
> > > > https://github.com/pevik/ima-evm-utils/actions/runs/4188761663/jobs/7260289846
> > > 
> > > The UML kernel built properly, but for some reason the fsverity and
> > > portable_signature tests aren't finding it.
> > 
> > It could be this (in the logs):
> > 
> > There exist one or more cache(s) with similar key but they have
> > different version or scope.
> > 
> > I would try:
> > 
> > enableCrossOsArchive: true
> > 
> > after:
> > 
> >       uses: actions/cache@v3
> >       with:
> >         path:
> >         key:
> > 
> > for every step using the cache.
> > 
> > Cache version is a hash generated for a combination of compression tool
> > used (Gzip, Zstd, etc. based on the runner OS) and the path of
> > directories being cached.
> > 
> > Maybe there was some change from the time the kernel and signing key
> > were cached.
> 
> Adding "enableCrossOsArchive: true" didn't help, nor did clearing the
> cache.

FYI, with a clean cache, but without any changes, this seems to be
working now.

> 
> 
> > 
> > > > FAIL: fsverity
> > > > ==============
> > > > 
> > > > which: no fsverity in (../src:../fsverity-utils:/github/home/ima-evm-utils-install/bin:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin)
> > > > dd is /usr/bin/dd
> > > > mkfs is /usr/sbin/mkfs
> > > > blkid is /usr/sbin/blkid
> > > > e2fsck is /usr/sbin/e2fsck
> > > > tune2fs is /usr/sbin/tune2fs
> > > > evmctl is ../src/evmctl
> > > > setfattr is /usr/bin/setfattr
> > > > ./functions.sh: line 90: ../linux: No such file or directory
> > > > =================================
> > > >  Run with FAILEARLY=1 ./fsverity.test _cleanup_env cleanup
> > > >  To stop after first failure
> > > > =================================
> > > > PASS: 0 SKIP: 0 FAIL: 1
> > > > 
> > > > FAIL fsverity.test (exit status: 1)
> > > > 
> > > > FAIL: portable_signatures
> > > > =========================
> > > > 
> > > > evmctl is /__w/ima-evm-utils/ima-evm-utils/tests/../src/evmctl
> > > > ./functions.sh: line 90: ../linux: No such file or directory
> > > > ./functions.sh: line 90: ../linux: No such file or directory
> > 
> 
> 


