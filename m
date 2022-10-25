Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D91A60D12C
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Oct 2022 17:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbiJYP7F (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Oct 2022 11:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbiJYP7E (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Oct 2022 11:59:04 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B2018D814;
        Tue, 25 Oct 2022 08:59:03 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PF2bsY022768;
        Tue, 25 Oct 2022 15:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=l647jSyUoAAxdm/botpD4Cfez584w6Z9p8C6pr/1rmk=;
 b=pmJNpWDCFGrnNDUzQd3WWNymzvvLTvWiQe8sUSGzz9T11NfhX5hqz5fwc+XzKv/U52sM
 zunMguBVKqRnwuZgF9EOJufanfRYqr1i1Z29SicwjrcTrrDspu9c7SVjgoi0FjqAFdcF
 aWeuPmBGunucVoAm4qOCzcLRwE+Y7VIFI9YfQ33zS4+Nd5hSRu3QV9h88aBbrhXqJYxu
 jX2eUkrWL3Eeh1FrzfDXp1RLd8TlQSY1vsO69p7kdI9sqVPXZKBbSRRLZz1rdi5ewwNy
 DbaGvzeN7vCS+r06f5mzqtySrD/pdlKMrJqG/d1DbehJp3NnKwgvXMoEoKjUK1CAbcNN ZQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3keea7jsk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Oct 2022 15:58:45 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29PFbaEX001722;
        Tue, 25 Oct 2022 15:58:44 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3keea7jsht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Oct 2022 15:58:44 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29PFaDfa026768;
        Tue, 25 Oct 2022 15:58:43 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma03dal.us.ibm.com with ESMTP id 3kc85ajutn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Oct 2022 15:58:43 +0000
Received: from smtpav06.dal12v.mail.ibm.com ([9.208.128.130])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29PFwdTT36045550
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 15:58:40 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BCD0D58060;
        Tue, 25 Oct 2022 15:58:41 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A85BD58063;
        Tue, 25 Oct 2022 15:58:40 +0000 (GMT)
Received: from sig-9-77-159-240.ibm.com (unknown [9.77.159.240])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 25 Oct 2022 15:58:40 +0000 (GMT)
Message-ID: <21fe8e7deb04596f0fdba621b657a21c00a074f1.camel@linux.ibm.com>
Subject: Re: [PATCH] evm: Correct inode_init_security hooks behaviors
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
Cc:     linux-integrity@vger.kernel.org, philippe.trebuchet@ssi.gouv.fr,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, davem@davemloft.net, lucien.xin@gmail.com,
        vgoyal@redhat.com, omosnace@redhat.com, mortonm@chromium.org,
        nicolas.bouchinet@ssi.gouv.fr, mic@digikod.net,
        cgzones@googlemail.com, linux-security-module@vger.kernel.org,
        brauner@kernel.org, keescook@chromium.org
Date:   Tue, 25 Oct 2022 11:58:40 -0400
In-Reply-To: <d18963ca-9c32-c360-144c-fb4a7949d20d@schaufler-ca.com>
References: <Y1FTSIo+1x+4X0LS@archlinux>
         <5edef60c775117758ecc146f1e8b96ef1c48e3da.camel@linux.ibm.com>
         <Y1Ki8838IAicXzlb@archlinux>
         <8607d166bbd2f32f1e71e5d7ce40b937eaeb410b.camel@linux.ibm.com>
         <Y1flvA2hJn2pNSiJ@archlinux>
         <4e645d7cb3c3d8c8c9af944130eb929851d5ba2f.camel@linux.ibm.com>
         <d18963ca-9c32-c360-144c-fb4a7949d20d@schaufler-ca.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3RHxNvj-ffxSLjgSZNONxPsBmtulvpwC
X-Proofpoint-GUID: mFzw9DO8YibTBee2W6x77oCz-629x7ds
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_09,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 adultscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210250089
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-10-25 at 08:06 -0700, Casey Schaufler wrote:
> On 10/25/2022 7:21 AM, Mimi Zohar wrote:
> > On Tue, 2022-10-25 at 15:33 +0200, Nicolas Bouchinet wrote:
> >>> Agreed, independently as to whether BPF defines a security xattr, if
> >>> two LSMs initialize security xattrs, then this change is needed.  Are
> >>> there any other examples?
> >> I think that in its current state the kernel cannot load two LSM capable of xattr
> >> initialization as they are all defined with the `LSM_FLAG_EXCLUSIVE` flag set.
> >> But I may be unaware of other LSM in development stage.
> > Casey, Paul, can we get confirmation on this?
> 
> I'm working really hard to eliminate LSM_FLAG_EXCLUSIVE. Dealing with
> multiple security modules initializing security xattrs has been in the
> stacking patch sets that have been in review for years now. So no,
> you can't wave the problem away by pointing at LSM_FLAG_EXCLUSIVE.

Please note that the original problem being addressed by this patch
will be addressed by Roberto's BPF patch.   The question here was
whether this addresses an existing bug, other than BPF, or a future
one, and whether it needs to be backported.

From your response, initializing multiple security xattrs is not an
issue at the moment so it doesn't need to be backported.  Whether this
patch should be upstreamed with the LSM stacking patch set is a
separate question.

> 
> >>> (nit: I understand the line size has generally been relaxed, but for
> >>> IMA/EVM I would prefer it to be remain as 80 chars.)
> >>>
> >> No problem, will change it !
> >>
> >> I'll take time to run few tests with BPF and send a patch v3 with new changes.
> > Since Roberto's patches will address the BPF bug(s), is this a fix for
> > a real bug or a possbile future one.   Cc'ing stable might not be
> > necessary.

-- 
thanks,

Mimi

