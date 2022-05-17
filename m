Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CB052AA8F
	for <lists+linux-integrity@lfdr.de>; Tue, 17 May 2022 20:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352045AbiEQSWM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 May 2022 14:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbiEQSWJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 May 2022 14:22:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772BD1D336;
        Tue, 17 May 2022 11:22:08 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HICMSK013805;
        Tue, 17 May 2022 18:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=yV5FjTW6aOdLLJ5GfzekGQ47jfBqvFOoSil7rFJpN1k=;
 b=SOwhDpLuF1BISd+/zK9p7zWBqsOwgKdz5TX/sa7P5C6Pe+XSOpOdzkykE2znVlGb4ZgP
 PIAHkjTz1RJB/zaAflVOtJrG9cREgwVgQfOgeRgG5IexoIIXdiKAZRTAx5SLsPKfVZH4
 47zq/I5OMXDuBuNeJ/BrkgZKjEBgetwyHTgcUSCvmgXmHyzJodG6NYQ5/fK3nlDusn3U
 1GpE8/xe4fFbS8nXFDh5MQ4wz0jKgyB75B5dzBhFgjl6JsfjT2U/XrMyDyAxlbiw7Qim
 sw1h+z3aRvhwpepr1DZKKrCVOmp7FDPrqm/k0denfvKaAy8w5zhx50xjSrM25fyjV+nl Eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g4gs7r65e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 18:21:18 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24HIF3Z2023921;
        Tue, 17 May 2022 18:21:17 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g4gs7r64n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 18:21:17 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24HI8hRo028569;
        Tue, 17 May 2022 18:21:14 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3g2428kqc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 18:21:14 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24HIKdlw33292696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 18:20:39 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 760B74C04A;
        Tue, 17 May 2022 18:21:12 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 650FB4C046;
        Tue, 17 May 2022 18:21:09 +0000 (GMT)
Received: from sig-9-65-95-105.ibm.com (unknown [9.65.95.105])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 17 May 2022 18:21:09 +0000 (GMT)
Message-ID: <4fe5564e860eb3093a88528ba1d30364d57723e0.camel@linux.ibm.com>
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
Date:   Tue, 17 May 2022 14:21:08 -0400
In-Reply-To: <YoPdfjswwA2wKinr@zx2c4.com>
References: <20220513145705.2080323-1-a.fatoum@pengutronix.de>
         <20220513145705.2080323-3-a.fatoum@pengutronix.de>
         <1c6a5ce2564c29a06eca255072a379351a5fc026.camel@linux.ibm.com>
         <YoPdfjswwA2wKinr@zx2c4.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: snNeX5_3_uw2TD-aDKNeaE6XMCoy0svW
X-Proofpoint-GUID: msDQgd47JUtzKxF1GBXOPQcnot1uj5Xy
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-17_03,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=877 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205170107
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-05-17 at 19:38 +0200, Jason A. Donenfeld wrote:
> On Tue, May 17, 2022 at 11:52:55AM -0400, Mimi Zohar wrote:
> > On Fri, 2022-05-13 at 16:57 +0200, Ahmad Fatoum wrote:
> > >  static int __init init_trusted(void)
> > >  {
> > > +       int (*get_random)(unsigned char *key, size_t key_len);
> > >         int i, ret = 0;
> > >  
> > >         for (i = 0; i < ARRAY_SIZE(trusted_key_sources); i++) {
> > > @@ -322,6 +333,28 @@ static int __init init_trusted(void)
> > >                             strlen(trusted_key_sources[i].name)))
> > >                         continue;
> > >  
> > > +               /*
> > > +                * We always support trusted.rng="kernel" and "default" as
> > > +                * well as trusted.rng=$trusted.source if the trust source
> > > +                * defines its own get_random callback.
> > > +                */
> >  
> > While TEE trusted keys support was upstreamed, there was a lot of
> > discussion about using kernel RNG.  One of the concerns was lack of or
> > insuffiencent entropy during early boot on embedded devices.  This
> > concern needs to be clearly documented in both Documentation/admin-
> > guide/kernel-parameters.txt and Documentation/security/keys/trusted-
> > encrypted.rst.
> 
> Sounds like FUD. Use `get_random_bytes_wait()`, and you'll be fine.

As per the original discussion, there's also certification requirements
[1].

Mimi

[1] https://lkml.org/lkml/2019/10/9/53


