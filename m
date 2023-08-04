Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1F576FFCC
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Aug 2023 13:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjHDL5p (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Aug 2023 07:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHDL5p (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Aug 2023 07:57:45 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104FFB1;
        Fri,  4 Aug 2023 04:57:43 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 374BkQ2G024137;
        Fri, 4 Aug 2023 11:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=byQd/e8jN/kbPxwrbt6oRtBnv6y+f/qK8WxI9qlnir8=;
 b=ChhJtqI6ThDJSvDMc3XC1jYS39HjNXgCIb6qJpYDmRNxv1uop/mFS2pcoUH5jzZloDc9
 g6CJcu53s0Jvo8uN1WUgf5pVGpOekcAZIeeLX+Ej7pPHNRrLq9b0nb1yseUbRW7R3jbE
 WBE8+5VT075gaGgNK5RX0uY2u5KeS1evdCz7qJVyf+lmByo9BU0K2QMJvTmFv3EeJQb0
 0az4kJWi6bUUsL8qOlnwIcQe5ZqgpURm8sNAWnCmX0YBndxTlmmDiWTPVnQn+NCOG6ls
 /KXP81kV/ugRbFQBxzO9mbvhh8hLSFbi5EJap8nG60XGaCaXxGxCkaEq6qZ7156u7fBG 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s90h6ge6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 11:57:15 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 374BkrKv025374;
        Fri, 4 Aug 2023 11:57:15 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s90h6ge65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 11:57:15 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 374BsG0t027822;
        Fri, 4 Aug 2023 11:57:14 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s8kp2w9bt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 11:57:14 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 374BvDUY19202554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Aug 2023 11:57:13 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D5F25804B;
        Fri,  4 Aug 2023 11:57:13 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B31F58065;
        Fri,  4 Aug 2023 11:57:12 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.12.187])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  4 Aug 2023 11:57:12 +0000 (GMT)
Message-ID: <84ddd923b49acb18946c1ecf5d773bcdadbea5c8.camel@linux.ibm.com>
Subject: Re: [PATCH -next] trusted-keys: Fix kernel-doc warnings in
 trusted-keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Paul Moore <paul@paul-moore.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Cc:     Gaosheng Cui <cuigaosheng1@huawei.com>, jarkko@kernel.org,
        dhowells@redhat.com, jejb@linux.ibm.com, jmorris@namei.org,
        serge@hallyn.com, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Date:   Fri, 04 Aug 2023 07:57:10 -0400
In-Reply-To: <CAHC9VhRQBOfdcYO5QLRgVGdbqLFrogXeVD3FT2cETmLhP5uz3A@mail.gmail.com>
References: <20230621074623.498647-1-cuigaosheng1@huawei.com>
         <CAHC9VhQzZYg1HH_Q6OYytkp-uYOmCAnpzHb9tiRA-YC0VNha9A@mail.gmail.com>
         <CAHC9VhQaWM=eC98ezfKmOA6sd9wzxQ0PFp5EysUKLZFEt=yB=A@mail.gmail.com>
         <CAHC9VhTibk2tFPt7ZjFL9ps9NO6_sCQwXtbF1pQCXO+jGhshpg@mail.gmail.com>
         <31a5aed2f075b69705142ff6f558e8cd8ccb9cd8.camel@linux.ibm.com>
         <CAHC9VhRQBOfdcYO5QLRgVGdbqLFrogXeVD3FT2cETmLhP5uz3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: H-MXVBczj5cDs_ruQzBUyyH3tMpI9D-K
X-Proofpoint-ORIG-GUID: KwepT0wnPBLx0hIIEDHT-Im1f8L_68ok
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_10,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 bulkscore=0 phishscore=0 malwarescore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308040102
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-08-03 at 19:20 -0400, Paul Moore wrote:
> On Thu, Aug 3, 2023 at 6:21 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > On Thu, 2023-08-03 at 18:00 -0400, Paul Moore wrote:
> > > On Tue, Jul 25, 2023 at 4:49 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Wed, Jun 21, 2023 at 9:33 AM Paul Moore <paul@paul-moore.com> wrote:
> > > > > On Wed, Jun 21, 2023 at 3:46 AM Gaosheng Cui <cuigaosheng1@huawei.com> wrote:
> > > > > >
> > > > > > Fix kernel-doc warnings in trusted-keys:
> > > > > >
> > > > > > security/keys/trusted-keys/trusted_tpm2.c:203: warning: expecting
> > > > > > prototype for tpm_buf_append_auth(). Prototype was for
> > > > > > tpm2_buf_append_auth() instead.
> > > > > >
> > > > > > Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> > > > > > ---
> > > > > >  security/keys/trusted-keys/trusted_tpm2.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > Reviewed-by: Paul Moore <paul@paul-moore.com>
> > > >
> > > > Jarkko, David, can one of you pick this up into your tree?
> > >
> > > Guys, this patch is both trivial and obviously correct, please pick it
> > > up so it can go up during the next merge window.
> >
> > Paul, either Jarkko or I can queue a trusted-keys patch.  As this isn't
> > on the top of Jarkko's radar, I'll queue it.
> 
> Ah ha!  I was working under the assumption that everything under
> security/keys/ was David and Jarko's responsibility, but now that I'm
> looking at MAINTAINERS I see that isn't the case.  In fact it looks
> like there are five (!) different "subsystems" under security/keys/
> ... I don't currently know enough about the different divisions there,
> but it seems like we might want to see if we can do some consolidation
> ...
> 
> Anyway, thanks for picking this up Mimi.

Thanks, Steven.  "6c95d71bad61 tracing: Fix kernel-doc warnings in
trace_seq.c " is in Linus' tree.

Mimi

