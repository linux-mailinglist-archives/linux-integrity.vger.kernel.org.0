Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4670060CED7
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Oct 2022 16:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbiJYOWM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Oct 2022 10:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbiJYOWJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Oct 2022 10:22:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6437E8BBA2;
        Tue, 25 Oct 2022 07:22:02 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PDexsG029886;
        Tue, 25 Oct 2022 14:21:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=+eiDI/g5BTd8an0yvyJo5yX/LHeG8fd3Yto5TSWzuDc=;
 b=g3Laa16RN1qP/jwzm0XMfXJgkNfsmWe5jX6T1b2V9whozchGr6q6nqrLEeJfqhx+Iq0E
 LfZ6Ib7YPtjKj5dAsJbFFEEEq3Bgywb/pAVEgL13dFgpJZFp+TAM++IgRUVG3RpStYrq
 Iu8EpsGiOMPxpyGGC/4pgfQaCWhgB9A/lagHn2+5cZoEGhiwCfhbauoq7aNAr4tyr8NC
 b+lnogMGg+zrZv6rNzc14aIQML6StelhEmGjxov46zakkKxDp75QpIvTOK5wKQsFJgkv
 Z6VNfKrX2Yc6Jgj9Ccaj5S/sQSBfeeZx4aHGvqU0r5BSg71D+mcN4mAMTpvQ7OWFF+Tl Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ked6r2crn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Oct 2022 14:21:36 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29PDrboi005084;
        Tue, 25 Oct 2022 14:21:35 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ked6r2cqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Oct 2022 14:21:35 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29PEKDa0015111;
        Tue, 25 Oct 2022 14:21:33 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma03wdc.us.ibm.com with ESMTP id 3kc85a8qtc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Oct 2022 14:21:33 +0000
Received: from smtpav01.wdc07v.mail.ibm.com ([9.208.128.113])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29PELWx018481766
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 14:21:33 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8422D58065;
        Tue, 25 Oct 2022 14:21:32 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C962858066;
        Tue, 25 Oct 2022 14:21:30 +0000 (GMT)
Received: from sig-9-77-159-240.ibm.com (unknown [9.77.159.240])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 25 Oct 2022 14:21:30 +0000 (GMT)
Message-ID: <4e645d7cb3c3d8c8c9af944130eb929851d5ba2f.camel@linux.ibm.com>
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
Date:   Tue, 25 Oct 2022 10:21:30 -0400
In-Reply-To: <Y1flvA2hJn2pNSiJ@archlinux>
References: <Y1FTSIo+1x+4X0LS@archlinux>
         <5edef60c775117758ecc146f1e8b96ef1c48e3da.camel@linux.ibm.com>
         <Y1Ki8838IAicXzlb@archlinux>
         <8607d166bbd2f32f1e71e5d7ce40b937eaeb410b.camel@linux.ibm.com>
         <Y1flvA2hJn2pNSiJ@archlinux>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kL4Itssm20278bgnhbfubEyVl1kE5_C_
X-Proofpoint-ORIG-GUID: mzhgm2ZMjnonBLY4qTf3QQyghp9_CnVQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_06,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 clxscore=1015 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=946 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210250081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-10-25 at 15:33 +0200, Nicolas Bouchinet wrote:
> > Agreed, independently as to whether BPF defines a security xattr, if
> > two LSMs initialize security xattrs, then this change is needed.  Are
> > there any other examples?
> 
> I think that in its current state the kernel cannot load two LSM capable of xattr
> initialization as they are all defined with the `LSM_FLAG_EXCLUSIVE` flag set.
> But I may be unaware of other LSM in development stage.

Casey, Paul, can we get confirmation on this?

> > 
> > (nit: I understand the line size has generally been relaxed, but for
> > IMA/EVM I would prefer it to be remain as 80 chars.)
> > 
> 
> No problem, will change it !
> 
> I'll take time to run few tests with BPF and send a patch v3 with new changes.

Since Roberto's patches will address the BPF bug(s), is this a fix for
a real bug or a possbile future one.   Cc'ing stable might not be
necessary.

thanks,

Mimi

