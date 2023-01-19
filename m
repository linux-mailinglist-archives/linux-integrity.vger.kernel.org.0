Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E24267376B
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Jan 2023 12:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjASLv4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Jan 2023 06:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjASLvv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Jan 2023 06:51:51 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1168F46086
        for <linux-integrity@vger.kernel.org>; Thu, 19 Jan 2023 03:51:49 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30J9phJG017732;
        Thu, 19 Jan 2023 11:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=MeyJhQmEHEbmYYRKJeE9uQ5O6zw3TUHNe3agZvmch4I=;
 b=CW6y0tx2TcvAH9HNHP7DsT2EYvZTxBRaFu7oDqzwfQ7VDJVHyXNYGySoY/G7iXS8ZnNQ
 2DtXEndLTufpWpF898opk5SV7VBAKPL5Qjg/lW6f4FW3D5/FyjH8UjWxUX6CBoRY1YyN
 ghMPLH0JpxXoHOkC2jvArwu8yEPOAVEJ3oC/J6+GLiIu8mTcoJYHXtJmhaZrKTsgc74g
 uvMEwwGm2U43i2y05tt4adZl/2K/ZMFc32vBFLGLw6Z6U+Dy8yxI07C1Xe8y3TDZNte6
 vGtCM9je16L9mFmbwtfjhhZO8nczKCtY1OUBRQDUJS1Wa+794J7X2yqWhSR7/AZAdqfH lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n7311bg15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 11:51:33 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30JBfJNU025891;
        Thu, 19 Jan 2023 11:51:33 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n7311bg0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 11:51:33 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30J9h3h4018747;
        Thu, 19 Jan 2023 11:51:31 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3n3m17kvqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 11:51:31 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30JBpUtP3539652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 11:51:30 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D18B58058;
        Thu, 19 Jan 2023 11:51:30 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2C1858063;
        Thu, 19 Jan 2023 11:51:29 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.185.113])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 19 Jan 2023 11:51:29 +0000 (GMT)
Message-ID: <a84ddb6329f9729fc864464b5c81a60944f66762.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v2 8/9] Use in-place built fsverity binary
 instead of installing it
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Thu, 19 Jan 2023 06:51:29 -0500
In-Reply-To: <faad3f8a6356ec8be90a66ce9bd80d40576f3cc2.camel@huaweicloud.com>
References: <20230112122426.3759938-1-roberto.sassu@huaweicloud.com>
         <20230112122426.3759938-9-roberto.sassu@huaweicloud.com>
         <42a75a49-31c8-4987-2b0d-83fef07d6cde@linux.ibm.com>
         <d6b9a9084c887372157e2deea29c20c9520ea63b.camel@huaweicloud.com>
         <b2081222-c8d7-0bc2-1e0a-368258c8a1c9@linux.ibm.com>
         <faad3f8a6356ec8be90a66ce9bd80d40576f3cc2.camel@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: G2v0vgdtli5QXqx4X08u-9IqdOLmpCO3
X-Proofpoint-GUID: UPF8CLgCAFcEsL5O7542zBQ48c_Eirpr
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_09,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190091
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-01-12 at 17:28 +0100, Roberto Sassu wrote:
> On Thu, 2023-01-12 at 11:26 -0500, Stefan Berger wrote:
> > 
> > On 1/12/23 11:20, Roberto Sassu wrote:
> > > On Thu, 2023-01-12 at 11:11 -0500, Stefan Berger wrote:
> > > > On 1/12/23 07:24, Roberto Sassu wrote:
> > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > 
> > > > > Instead of making changes to the system, use in-place built fsverity binary
> > > > > by adding ../fsverity-utils to the PATH variable, so that the binary can be
> > > > > found with the 'which' command.
> > > > > 
> > > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > 
> > > > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > 
> > > > > ---
> > > > >    tests/fsverity.test       | 2 +-
> > > > >    tests/install-fsverity.sh | 2 +-
> > > > >    2 files changed, 2 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/tests/fsverity.test b/tests/fsverity.test
> > > > > index 84312aa08a30..e05978be7ea6 100755
> > > > > --- a/tests/fsverity.test
> > > > > +++ b/tests/fsverity.test
> > > > > @@ -30,7 +30,7 @@
> > > > >    # custom policy rules might take precedence.
> > > > >    
> > > > >    cd "$(dirname "$0")" || exit 1
> > > > > -PATH=../src:$PATH
> > > > > +PATH=../src:../fsverity-utils:$PATH
> > > > >    source ./functions.sh
> > > > >    
> > > > >    # Base VERBOSE on the environment variable, if set.
> > > > > diff --git a/tests/install-fsverity.sh b/tests/install-fsverity.sh
> > > > > index 418fc42f472b..d00674c0d3a2 100755
> > > > > --- a/tests/install-fsverity.sh
> > > > > +++ b/tests/install-fsverity.sh
> > > > > @@ -2,6 +2,6 @@
> > > > >    
> > > > >    git clone https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/fsverity-utils.git
> > > > >    cd fsverity-utils
> > > > > -CC=gcc make -j$(nproc) && sudo make install
> > > > > +CC=gcc make -j$(nproc)
> > > > >    cd ..
> > > > >    rm -rf fsverity-utils
> > > 
> > > Argh... same problem.
> > > 
> > > Will just delete the last two lines. It is just for CI.
> > 
> > Must be skipping tests when the tool is not found
> 
> Yes, it does:
> 
> SKIP: fsverity is not installed
> PASS: 0 SKIP: 0 FAIL: 0

RH doesn't have the fsverity-utils package.  tests/install-fsverity.sh
builds and installs it.  The script ci/fedora.sh builds and installs
it.

Mimi

