Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32B360CEDF
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Oct 2022 16:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiJYOXK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Oct 2022 10:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiJYOW6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Oct 2022 10:22:58 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AD489CED;
        Tue, 25 Oct 2022 07:22:56 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PDf1Rr001977;
        Tue, 25 Oct 2022 14:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=m3kfXLls4h2vQSbXnYeaxOalhXBMoRnMgy4GDxvjKpk=;
 b=qi6QjDRg16af6Utg8aF1YhqiNXla3WSEl65u4/F9lwygT5jwJVZGvdP26QsP5m39IIa7
 7X/814Olqth/Oz92M2tBg3kUeQ3MXst1+WEJ7ZSsDv+LPBIEzZZrpby20iRlBxtW8+YE
 nSVdjQ2MTw/oRNQ5mSvBnqvOO6NLd4gWFLSPFi0bNM8ncwUrNswghPmBjzARdrn2gpG1
 sZveZsEHFN0ATqJdn+cjhDr6k35h4ewWBaatVRUwWmMhZqUeNC87SeAFwqX99AMtjSiF
 spHhX5m0Xorr2LLy+lpJYyRM5NHmoniiAd6pJEzGn190qRhHC5KZigDEHqZ8VKjTc9GH 5w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kee98yfq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Oct 2022 14:22:41 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29PDf111001969;
        Tue, 25 Oct 2022 14:22:41 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kee98yfnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Oct 2022 14:22:40 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29PELQhD001408;
        Tue, 25 Oct 2022 14:22:39 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04wdc.us.ibm.com with ESMTP id 3kc859ebgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Oct 2022 14:22:39 +0000
Received: from smtpav02.wdc07v.mail.ibm.com ([9.208.128.114])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29PEMcdW20316774
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 14:22:38 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E17265805C;
        Tue, 25 Oct 2022 14:22:37 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2CAF5805F;
        Tue, 25 Oct 2022 14:22:35 +0000 (GMT)
Received: from sig-9-77-159-240.ibm.com (unknown [9.77.159.240])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 25 Oct 2022 14:22:35 +0000 (GMT)
Message-ID: <e486cbbd3bbb7faa3b7f3118dc162fdfbc7e3ed6.camel@linux.ibm.com>
Subject: Re: [PATCH] evm: Correct inode_init_security hooks behaviors
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
Cc:     linux-integrity@vger.kernel.org, philippe.trebuchet@ssi.gouv.fr,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, casey@schaufler-ca.com, davem@davemloft.net,
        lucien.xin@gmail.com, vgoyal@redhat.com, omosnace@redhat.com,
        mortonm@chromium.org, nicolas.bouchinet@ssi.gouv.fr,
        mic@digikod.net, cgzones@googlemail.com,
        linux-security-module@vger.kernel.org, brauner@kernel.org,
        keescook@chromium.org
Date:   Tue, 25 Oct 2022 10:22:35 -0400
In-Reply-To: <4e645d7cb3c3d8c8c9af944130eb929851d5ba2f.camel@linux.ibm.com>
References: <Y1FTSIo+1x+4X0LS@archlinux>
         <5edef60c775117758ecc146f1e8b96ef1c48e3da.camel@linux.ibm.com>
         <Y1Ki8838IAicXzlb@archlinux>
         <8607d166bbd2f32f1e71e5d7ce40b937eaeb410b.camel@linux.ibm.com>
         <Y1flvA2hJn2pNSiJ@archlinux>
         <4e645d7cb3c3d8c8c9af944130eb929851d5ba2f.camel@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 938hypMwN7C-28Xww4EyKe-u1dYVqL1D
X-Proofpoint-ORIG-GUID: QfuiAkXCeu5em7CVakmAKPvD2BytRdlY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_06,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210250081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-10-25 at 10:21 -0400, Mimi Zohar wrote:
> On Tue, 2022-10-25 at 15:33 +0200, Nicolas Bouchinet wrote:
> > > Agreed, independently as to whether BPF defines a security xattr, if
> > > two LSMs initialize security xattrs, then this change is needed.  Are
> > > there any other examples?
> > 
> > I think that in its current state the kernel cannot load two LSM capable of xattr
> > initialization as they are all defined with the `LSM_FLAG_EXCLUSIVE` flag set.
> > But I may be unaware of other LSM in development stage.
> 
> Casey, Paul, can we get confirmation on this?
> 
> > > 
> > > (nit: I understand the line size has generally been relaxed, but for
> > > IMA/EVM I would prefer it to be remain as 80 chars.)
> > > 
> > 
> > No problem, will change it !
> > 
> > I'll take time to run few tests with BPF and send a patch v3 with new changes.
> 
> Since Roberto's patches will address the BPF bug(s), is this a fix for
> a real bug or a possbile future one.   Cc'ing stable might not be
> necessary.

And the patch description will need to be updated accordingly.

thanks,

Mimi

