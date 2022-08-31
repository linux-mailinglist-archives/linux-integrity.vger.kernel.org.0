Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24985A8105
	for <lists+linux-integrity@lfdr.de>; Wed, 31 Aug 2022 17:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiHaPRR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 31 Aug 2022 11:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiHaPRQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 31 Aug 2022 11:17:16 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F672D7406
        for <linux-integrity@vger.kernel.org>; Wed, 31 Aug 2022 08:17:15 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VF7L7S002414;
        Wed, 31 Aug 2022 15:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=aHQWjHmUF1AjwJWjp5slT2+hsKYbsgn6NuVscRvALTw=;
 b=Da94Afo/24QD4oWBHSbfjtU6Sc0RCgeo6M4l/Lh6Vgtzn5mlPZwQCBdUxnoumEJD4gNy
 vggm1btPaVYO7vcdPg1wCVTan2djNIoJbLHCUSvrds6ar3yIYQLsOX9xc1EaEmouIREX
 0Bdc6NVEWFNAbsnl+ZmhQpHyId/HHbvRuqwqS8B7P6HAqm3pGoRtzzFc1kF23a7JWe+8
 Uy+z7wu77LDBXFXhZUb7Ib7KmnHt98App2DKdjJ4iHwMqpkicxLdNgDjFLoJ9TojzgkM
 lbDcnEJrSodLCSIodb0j/yxQhR4f+JD1cOUJwduNMZ4eKtHUbUJnXTkyZ+cvYtFCWBSr 7A== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ja9mpsh4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Aug 2022 15:17:10 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27VEo73m013478;
        Wed, 31 Aug 2022 15:17:09 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 3j7aw9svs1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Aug 2022 15:17:09 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27VFH8rq4719212
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Aug 2022 15:17:08 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C113DC6057;
        Wed, 31 Aug 2022 15:17:07 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C1B5C6055;
        Wed, 31 Aug 2022 15:17:07 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.126.199])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 31 Aug 2022 15:17:07 +0000 (GMT)
Message-ID: <26d85020c655aa981627860a962090936914486f.camel@linux.ibm.com>
Subject: Re: [RFC PATCH ima-evm-utils 04/11] Deprecate IMA signature version
 1
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>
Date:   Wed, 31 Aug 2022 11:17:07 -0400
In-Reply-To: <6958893d-d370-6906-0862-6c52b9ce701f@linux.ibm.com>
References: <20220830005936.189922-1-zohar@linux.ibm.com>
         <20220830005936.189922-5-zohar@linux.ibm.com>
         <6958893d-d370-6906-0862-6c52b9ce701f@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eGS5fAKpuTTi48Xiz1WVFZ8oj0-r6W3R
X-Proofpoint-GUID: eGS5fAKpuTTi48Xiz1WVFZ8oj0-r6W3R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_09,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208310075
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-08-30 at 08:12 -0400, Stefan Berger wrote:
> > @@ -747,6 +756,7 @@ int ima_verify_signature(const char *file, unsigned char *sig, int siglen,
> >    */
> >   int key2bin(RSA *key, unsigned char *pub)
> >   {
> > +#if CONFIG_SIGV1
> >       int len, b, offset = 0;
> >       struct pubkey_hdr *pkh = (struct pubkey_hdr *)pub;
> >       const BIGNUM *n, *e;
> > @@ -781,10 +791,14 @@ int key2bin(RSA *key, unsigned char *pub)
> >       offset += len;
> >   
> >       return offset;
> > +#else
> > +     return 77; /* SKIP */
> > +#endif
> >   }
> 
> This function has no callers if CONFIG_SIGV1 is not set and otherwise 
> it's useless also if someone was a user of the library only. I would 
> consider ifdef'ing the whole function...

Agreed.  key2bin() and calc_keyid_v1() are now fully commented out in
the next version, as well as cmd_convert() and read_pub_key() as you
suggested.

> 
> >   
> >   void calc_keyid_v1(uint8_t *keyid, char *str, const unsigned char *pkey, int len)
> >   {
> > +#if CONFIG_SIGV1
> >       uint8_t sha1[SHA_DIGEST_LENGTH];
> >       uint64_t id;
> >   
> > @@ -799,6 +813,7 @@ void calc_keyid_v1(uint8_t *keyid, char *str, const unsigned char *pkey, int len
> >   
> >       if (imaevm_params.verbose > LOG_INFO)
> >               log_info("keyid-v1: %s\n", str);
> > +#endif
> >   }

-- 
thanks,

Mimi

