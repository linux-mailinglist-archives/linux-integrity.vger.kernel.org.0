Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7575376F597
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Aug 2023 00:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjHCWVJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Aug 2023 18:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjHCWVI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Aug 2023 18:21:08 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1B0212D;
        Thu,  3 Aug 2023 15:21:07 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373MEKmh010326;
        Thu, 3 Aug 2023 22:20:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=J94tjLs7NSAtXHZpjBBYmnDnVDQrX+eytO+yIXyB3B4=;
 b=YZrOd00t9u52oYMDCrBbE/PDVyhBHmrDuHFTvS//H2rm0u6/CdmNSF+V8I6twLnV5Ms9
 Dyf4asJTTuRcVVS+sRGMcNCwag2YQPYuAw/QNsgERtH+GtFHl6W6MGoERZnH1gRIgpLx
 xaVbC6L1yMPTarTcZYUnmy8HSIXMxFBO5lObzBpOjn361woqzLLyLKNeHXI6tpeWUeOc
 R4p6JSBJPu9S3IkJxgtaMt1scBgmsTrrwL0hpl3DD/UcENcM86lqIwrwHLHZA5VQglYV
 vZ2CtiEgz0sefTculZIoqUz+DBm0RIeIcpOnp0788e5SsRGgC4/fBArwfxWeJAdUNrNj 2g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s8mun83h7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 22:20:49 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 373MJK9Q023657;
        Thu, 3 Aug 2023 22:20:48 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s8mun83gx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 22:20:48 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 373KrZtM022105;
        Thu, 3 Aug 2023 22:20:48 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s8kp2rgym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 22:20:47 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 373MKlNR64225720
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Aug 2023 22:20:47 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F43B58056;
        Thu,  3 Aug 2023 22:20:47 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 078B25803F;
        Thu,  3 Aug 2023 22:20:47 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.157.226])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  3 Aug 2023 22:20:46 +0000 (GMT)
Message-ID: <31a5aed2f075b69705142ff6f558e8cd8ccb9cd8.camel@linux.ibm.com>
Subject: Re: [PATCH -next] trusted-keys: Fix kernel-doc warnings in
 trusted-keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Paul Moore <paul@paul-moore.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>, jarkko@kernel.org,
        dhowells@redhat.com
Cc:     jejb@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Thu, 03 Aug 2023 18:20:46 -0400
In-Reply-To: <CAHC9VhTibk2tFPt7ZjFL9ps9NO6_sCQwXtbF1pQCXO+jGhshpg@mail.gmail.com>
References: <20230621074623.498647-1-cuigaosheng1@huawei.com>
         <CAHC9VhQzZYg1HH_Q6OYytkp-uYOmCAnpzHb9tiRA-YC0VNha9A@mail.gmail.com>
         <CAHC9VhQaWM=eC98ezfKmOA6sd9wzxQ0PFp5EysUKLZFEt=yB=A@mail.gmail.com>
         <CAHC9VhTibk2tFPt7ZjFL9ps9NO6_sCQwXtbF1pQCXO+jGhshpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tQb5cWjKssgTUgceOD4trAYZqC4Bcysk
X-Proofpoint-ORIG-GUID: e9MDNwE43T5FD8_-GOcKGxZCUkF7VNr-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_22,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1011 suspectscore=0 mlxlogscore=911
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308030198
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-08-03 at 18:00 -0400, Paul Moore wrote:
> On Tue, Jul 25, 2023 at 4:49 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Wed, Jun 21, 2023 at 9:33 AM Paul Moore <paul@paul-moore.com> wrote:
> > > On Wed, Jun 21, 2023 at 3:46 AM Gaosheng Cui <cuigaosheng1@huawei.com> wrote:
> > > >
> > > > Fix kernel-doc warnings in trusted-keys:
> > > >
> > > > security/keys/trusted-keys/trusted_tpm2.c:203: warning: expecting
> > > > prototype for tpm_buf_append_auth(). Prototype was for
> > > > tpm2_buf_append_auth() instead.
> > > >
> > > > Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> > > > ---
> > > >  security/keys/trusted-keys/trusted_tpm2.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > Reviewed-by: Paul Moore <paul@paul-moore.com>
> >
> > Jarkko, David, can one of you pick this up into your tree?
> 
> Guys, this patch is both trivial and obviously correct, please pick it
> up so it can go up during the next merge window.

Paul, either Jarkko or I can queue a trusted-keys patch.  As this isn't
on the top of Jarkko's radar, I'll queue it.

Mimi

