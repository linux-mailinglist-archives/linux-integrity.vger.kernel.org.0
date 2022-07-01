Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1124C563C73
	for <lists+linux-integrity@lfdr.de>; Sat,  2 Jul 2022 00:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiGAWni (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 1 Jul 2022 18:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiGAWng (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 1 Jul 2022 18:43:36 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA072980F
        for <linux-integrity@vger.kernel.org>; Fri,  1 Jul 2022 15:43:36 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 261MSmxV026178;
        Fri, 1 Jul 2022 22:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Bey6zCQiCL/DGMTl7Gf++tLWWDv4koCBCwWXduf+5pc=;
 b=mLaWYjhQZyqAp639QvlryvIYEjjYEdzL9+apZS+fVaMs2typA/iy4k3iudjeILozbDO+
 AZssKJTqBEz8F0ijXOZAwuBvW9aeu3sPaNefU3MkCI9KpNEskg2DEl/MSKoNo0Li+pLm
 nuRdIxi+OlnhtGBHaHX6GeTpYz+TTEVGLWQ0Y1uewFubK2yOkMHTzI8k4mAqN+7FWSfn
 OMlpi7UIiAaf3GPcmgodcp5m7vQtDBcFx48W48cT6kv6nsa30kaymsxNN8Iq+5Wv/x59
 iLDKiwTxcIRg6P+mc+QHbPwGzgv3m9tg63c0UXYRizmd8sOellgwN9kCjJcCllGp+B/4 eQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h29rnr8kq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jul 2022 22:43:33 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 261MbZGt008375;
        Fri, 1 Jul 2022 22:43:31 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3gwt092766-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jul 2022 22:43:31 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 261MhSsN18284900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Jul 2022 22:43:28 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E0CE4C046;
        Fri,  1 Jul 2022 22:43:28 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71A3E4C040;
        Fri,  1 Jul 2022 22:43:27 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.154.188])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 Jul 2022 22:43:27 +0000 (GMT)
Message-ID: <3077f189ad6e50e7c223199c36e6f635623fdf8b.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: fix violation measurement list record
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jonathan McDowell <noodles@earth.li>
Cc:     linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Date:   Fri, 01 Jul 2022 18:43:26 -0400
In-Reply-To: <Yr94LQGboFv4f1xG@earth.li>
References: <20220701201325.396766-1-zohar@linux.ibm.com>
         <Yr94LQGboFv4f1xG@earth.li>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9Ig5ZL0aEVgHmAfXt-Gb981J5eKA0Svi
X-Proofpoint-ORIG-GUID: 9Ig5ZL0aEVgHmAfXt-Gb981J5eKA0Svi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-01_15,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 clxscore=1011 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207010090
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2022-07-01 at 23:41 +0100, Jonathan McDowell wrote:
> On Fri, Jul 01, 2022 at 04:13:25PM -0400, Mimi Zohar wrote:
> > Although the violation digest in the IMA measurement list is always
> > zeroes, the size of the digest should be based on the hash algorithm.
> > Until recently the hash algorithm was hard coded to sha1.  Fix the
> > violation digest size included in the IMA measurement list.
> > 
> > This is just a cosmetic which should not affect attestation.
> > 
> > Reported-by: Stefan Berger <stefanb@linux.ibm.com>
> > Fixes: 09091c44cb73 ("ima: use IMA default hash algorithm for integrity violations")
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > ---
> >  security/integrity/ima/ima_template_lib.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
> > index c877f01a5471..67359845c975 100644
> > --- a/security/integrity/ima/ima_template_lib.c
> > +++ b/security/integrity/ima/ima_template_lib.c
> > @@ -326,7 +326,7 @@ static int ima_eventdigest_init_common(const u8 *digest, u32 digestsize,
> >  		 * Make room for the digest by increasing the offset of
> >  		 * IMA_DIGEST_SIZE.
> >  		 */
> > -		offset += IMA_DIGEST_SIZE;
> > +		offset += hash_digest_size[hash_algo];
> 
> Update the comment as well?

Yes, of course.  Thank you for catching it!

Mimi


> 
> >  	return ima_write_template_field_data(buffer, offset + digestsize,
> >  					     fmt, field_data);
> > -- 
> > 2.27.0
> > 
> 
> J.
> 


