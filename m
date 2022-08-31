Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C9E5A7CC5
	for <lists+linux-integrity@lfdr.de>; Wed, 31 Aug 2022 14:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiHaMCh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 31 Aug 2022 08:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiHaMCh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 31 Aug 2022 08:02:37 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A992D2900
        for <linux-integrity@vger.kernel.org>; Wed, 31 Aug 2022 05:02:34 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VBF6it039784;
        Wed, 31 Aug 2022 12:02:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=CPZRjpj5qg+VagOx4Bmniq+rRGoeqtv8nxALahJfmkQ=;
 b=hp2SAvNeiERCdLgMXb4npECd1+/K13MkxBT9rOWKo6e3I0fdxnb+7/VC+QCTlM521atg
 018w+QWkrqy1RKh6OOBXtS2NyFu/u0PJbxi7h6LXIP/f76IIUnoIWzTBGTGg8wLay00A
 6RrQmgOiBygh856/rgxkg6/lZWgaQC/B6q2DhW+s2MC4DENLZqheIIOGdLDCPCno/54S
 2cgxODhEN8e5UjlY968+dwmNorkBYuRa6nk40p1vPTv68lqhaaVNLzFCvg/yxQZrBXwI
 qj4+dIFMRqCJHiNa1o8Z3gzGEW8GF8pch3mPrmUESeYl5YS3ipPazNR7D3S2pI4UAd1d 4g== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ja6kp1gu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Aug 2022 12:02:28 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27VBqPca005596;
        Wed, 31 Aug 2022 12:02:27 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma03dal.us.ibm.com with ESMTP id 3j7awb0qwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Aug 2022 12:02:27 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27VC2Q4158786198
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Aug 2022 12:02:26 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2ABEB2066;
        Wed, 31 Aug 2022 12:02:26 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0263CB2064;
        Wed, 31 Aug 2022 12:02:25 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.126.199])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 31 Aug 2022 12:02:25 +0000 (GMT)
Message-ID: <1ec8cda85a12d9bb33da152b73c486185429bae9.camel@linux.ibm.com>
Subject: Re: [RFC PATCH ima-evm-utils 08/11] Deprecate use of OpenSSL 3
 "engine" support
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Stefan Berger <stefanb@linux.ibm.com>
Date:   Wed, 31 Aug 2022 08:02:25 -0400
In-Reply-To: <20220830205254.w6cahikybwzmxwkx@altlinux.org>
References: <20220830005936.189922-1-zohar@linux.ibm.com>
         <20220830005936.189922-9-zohar@linux.ibm.com>
         <20220830030353.lwggzfsqmalpznoy@altlinux.org>
         <30cc0eab23501c33ab3d2a8e2a6548b92ce9a127.camel@linux.ibm.com>
         <20220830205254.w6cahikybwzmxwkx@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wrxYbWCeawaFlKCHJk-OVw5v15BAVBTY
X-Proofpoint-GUID: wrxYbWCeawaFlKCHJk-OVw5v15BAVBTY
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_07,2022-08-31_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208310060
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-08-30 at 23:52 +0300, Vitaly Chikunov wrote:

> > > Also engine could be loaded via openssl.cnf/OPENSSL_CONF, in that case
> > > --engine option is not needed but engine is still there to use/test.
> > 
> > Thank you for reminding me that engine support based on the OpenSSL
> > configuration also needs to be deprecated.
> 
> I'm curious - how would you deprecate that? As this should be
> transparent to the libcrypto clients - new functionality and algorithms
> just appear.

I'm referring to commit 782224f33cd7 ("ima-evm-utils: Rework openssl
init"), which introduced "--disable-openssl-conf".

>  
> > > GOST tests try to handle absence of algorithms (can work w/o --engine
> > > option if configured via openssl config) and skip gracefully.
> > > Perhaps this check should be moved below them just for pkcs11 tests
> > > if they are so sensitive.
> > 
> > Does OpenSSL v3 differentiate how engines are configured?  I assume
> > when engine support is removed, all of it will be removed.
> 
> Perhaps. But providers are configured similarly via config - there
> config examples for some gost-engine Perl tests:
>   as engine https://github.com/gost-engine/engine/blob/master/test/engine.cnf
>   as provider https://github.com/gost-engine/engine/blob/master/test/provider.cnf

Ok.  Thank you for the reference.

Mimi

