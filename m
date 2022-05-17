Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0E652AC41
	for <lists+linux-integrity@lfdr.de>; Tue, 17 May 2022 21:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352045AbiEQTuM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 May 2022 15:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbiEQTuL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 May 2022 15:50:11 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BAD381A2;
        Tue, 17 May 2022 12:50:08 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HJj5nj007921;
        Tue, 17 May 2022 19:49:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=cI+oIgMmdU+emHoSmuCJfl7DDPI2DU7nUb6sIjNnUjE=;
 b=nscihTpC5el6eAjl9Tw2n8BGB6v1zMOzGVCtmzaVZPnqNZAbi5po8qQ1qn/cFPQ9tUMd
 JUUr+Gdln/DDgPqmOsUw9fuHg/2qY4hgDnHH/YTp9LNjMCxxJL96C82s20RBz15Cgm4+
 52ayLYVLllYK4DECR5twGsmWzujhuPCa2cu8E44kY3rV1wZiQg9b4B5OKLsgRC+gmpSp
 sOwmtPcHeP8XzJpYowjxz12Wn3G2roVoNGIJj5E6uRB4HNFQKCF3h1Vm5RfIRLxi1fCy
 9IuCjDFXuy6PGlcbPHWuoh+hhIC/VILAI95p0+R+Pnuh5Kri7uoX1V9DQyyRL/o0f1KE Xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g4j5001wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 19:49:44 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24HJnWm0021912;
        Tue, 17 May 2022 19:49:43 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g4j5001w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 19:49:43 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24HJglUj004965;
        Tue, 17 May 2022 19:49:41 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3g2429cpp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 19:49:41 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24HJncO358982762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 19:49:38 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFB4C11C050;
        Tue, 17 May 2022 19:49:38 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AB7811C054;
        Tue, 17 May 2022 19:49:35 +0000 (GMT)
Received: from sig-9-65-95-105.ibm.com (unknown [9.65.95.105])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 17 May 2022 19:49:35 +0000 (GMT)
Message-ID: <dd488736ab86c0e0b2809b4ce30f1827563b52b2.camel@linux.ibm.com>
Subject: Re: [PATCH v10 2/7] KEYS: trusted: allow use of kernel RNG for key
 material
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>, kernel@pengutronix.de,
        Sumit Garg <sumit.garg@linaro.org>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        David Gstir <david@sigma-star.at>,
        Michael Walle <michael@walle.cc>,
        John Ernberg <john.ernberg@actia.se>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Horia =?UTF-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>
Date:   Tue, 17 May 2022 15:49:34 -0400
In-Reply-To: <YoPpyDjn61AFqcZp@zx2c4.com>
References: <20220513145705.2080323-1-a.fatoum@pengutronix.de>
         <20220513145705.2080323-3-a.fatoum@pengutronix.de>
         <1c6a5ce2564c29a06eca255072a379351a5fc026.camel@linux.ibm.com>
         <YoPdfjswwA2wKinr@zx2c4.com>
         <4fe5564e860eb3093a88528ba1d30364d57723e0.camel@linux.ibm.com>
         <YoPpyDjn61AFqcZp@zx2c4.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PbWP-fmv3bYEWPSRRHfxdQcuFVuveDXv
X-Proofpoint-GUID: wTyBvInx9LJoH0s5-vgBBc7fDZWpQaOW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-17_03,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 impostorscore=0 mlxscore=0
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205170111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-05-17 at 20:30 +0200, Jason A. Donenfeld wrote:
> Hi Mimi,
> 
> On Tue, May 17, 2022 at 02:21:08PM -0400, Mimi Zohar wrote:
> > On Tue, 2022-05-17 at 19:38 +0200, Jason A. Donenfeld wrote:
> > > On Tue, May 17, 2022 at 11:52:55AM -0400, Mimi Zohar wrote:
> > > > On Fri, 2022-05-13 at 16:57 +0200, Ahmad Fatoum wrote:
> > > > >  static int __init init_trusted(void)
> > > > >  {
> > > > > +       int (*get_random)(unsigned char *key, size_t key_len);
> > > > >         int i, ret = 0;
> > > > >  
> > > > >         for (i = 0; i < ARRAY_SIZE(trusted_key_sources); i++) {
> > > > > @@ -322,6 +333,28 @@ static int __init init_trusted(void)
> > > > >                             strlen(trusted_key_sources[i].name)))
> > > > >                         continue;
> > > > >  
> > > > > +               /*
> > > > > +                * We always support trusted.rng="kernel" and "default" as
> > > > > +                * well as trusted.rng=$trusted.source if the trust source
> > > > > +                * defines its own get_random callback.
> > > > > +                */
> > > >  
> > > > While TEE trusted keys support was upstreamed, there was a lot of
> > > > discussion about using kernel RNG.  One of the concerns was lack of or
> > > > insuffiencent entropy during early boot on embedded devices.  This
> > > > concern needs to be clearly documented in both Documentation/admin-
> > > > guide/kernel-parameters.txt and Documentation/security/keys/trusted-
> > > > encrypted.rst.
> > > 
> > > Sounds like FUD. Use `get_random_bytes_wait()`, and you'll be fine.
> > 
> > As per the original discussion, there's also certification requirements
> > [1].
> 
> As per countless conversations on this mailing list -- which I really
> really really hope you will not attempt to drown me in again -- I'm not
> too keen on the certification requirements. Let's just leave that
> conversation there.
> 
> There *is* a cryptographic design reason why you might want certain keys
> generated on a TPM rather than in the kernel though: so that the keys
> can be marked as unexportable and never leave the hardware. In that case
> -- I assume -- the kernel just operates on a handle to the key, rather
> than possessing the key material itself. And this is probably a good
> thing. (On the other hand, people who think the TPM might be backdoored
> may prefer the kernel's open source RNG, which in theory is in a
> position to aggregate entropy from many sources, so that one being
> backdoored isn't a problem. So maybe that's the purpose of having this
> switch?)
> 
> So to the extent that this driver (I haven't looked deeply at it) is
> doing the thing where a TPM generates the key and just returns a
> handle to it, that sounds good. But if actually you're implementing some
> wrapper around a hardware rng, it'd be convenient if there was instead a
> hw_random driver for this, so it can be one of the many sources that the
> kernel rng aggregates.
> 
> Apologies in advance if I've missed the mark here; I'm not very familiar
> with this thread or what it's driving at. If the simple question was
> just "is get_random_bytes_wait() good to use?" the answer is just "yes"
> and I can disappear and stop confusing things. :)

My apologies for your having been brought into this discussion without
having properly reviewed and summarized the previous thread.   As you
saw there is a long history.

Jarrko, Ahmad,  "Trusted" keys, by definition, are based on the TPM
RNG.  If CAAM trusted key support wants to use kernel RNG by default,
that's fine.  However defining and allowing a boot command line option
to use kernel RNG instead of the TPM RNG, needs to be configurable.

thanks,

Mimi

