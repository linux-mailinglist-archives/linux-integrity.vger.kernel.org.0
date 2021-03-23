Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A084346737
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Mar 2021 19:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhCWSI3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Mar 2021 14:08:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8152 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231206AbhCWSIE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Mar 2021 14:08:04 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12NI5RMu111568;
        Tue, 23 Mar 2021 14:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=odnY6h4coq5urn2CzhCmZB0m7u2bx8U3SIbESLNrZHY=;
 b=rPhhJ/cw3twDW6aAEbsHiIs0DmmbFXQV4Cc8im/7PPbKiPnl9n3kV8I3K+g9FJy8UqMd
 CYd0gBDTdbJ2Gw1U4V7qnUVhWYDHuHiuVS/RYYEw1ama0VoPZltjPhUzeTm/eNKVQsD3
 kRy8ChD/IOoX8cu92zuq0XPateWtdfGv/9GRGRctmJnfhGlhu2fwMzSJAy+eEav4zp6s
 XzypMbC06UtYHSlP8KtiHdck3hexTDBs7onedG2QKbsM7DCb34tvNVVjaKDNjv278xqr
 ewSlnkjLHctWkQhicrgrCt6cUPydjU+NxXee+98KQ+q4uhXXZsV5zIC6KS9n2nrPgjb4 0A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37fm6ut8tr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 14:07:32 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12NI6tUB119695;
        Tue, 23 Mar 2021 14:07:32 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37fm6ut8s9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 14:07:32 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12NI3m6k003991;
        Tue, 23 Mar 2021 18:07:29 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 37d9bpsvhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 18:07:29 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12NI7QRc41222406
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 18:07:26 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91417AE045;
        Tue, 23 Mar 2021 18:07:26 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41294AE04D;
        Tue, 23 Mar 2021 18:07:21 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.72.148])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 23 Mar 2021 18:07:20 +0000 (GMT)
Message-ID: <f9c0087d299be1b9b91b242f41ac6ef7b9ee3ef7.camel@linux.ibm.com>
Subject: Re: [PATCH v1 3/3] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Horia =?UTF-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <jejb@linux.ibm.com>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Date:   Tue, 23 Mar 2021 14:07:20 -0400
In-Reply-To: <45a9e159-2dcb-85bf-02bd-2993d50b5748@pengutronix.de>
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de>
         <319e558e1bd19b80ad6447c167a2c3942bdafea2.1615914058.git-series.a.fatoum@pengutronix.de>
         <01e6e13d-2968-0aa5-c4c8-7458b7bde462@nxp.com>
         <45a9e159-2dcb-85bf-02bd-2993d50b5748@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
X-TM-AS-GCONF: 00
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-23_09:2021-03-22,2021-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103230133
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-03-23 at 17:35 +0100, Ahmad Fatoum wrote:
> Hello Horia,
> 
> On 21.03.21 21:48, Horia Geantă wrote:
> > On 3/16/2021 7:02 PM, Ahmad Fatoum wrote:
> > [...]
> >> +struct trusted_key_ops caam_trusted_key_ops = {
> >> +	.migratable = 0, /* non-migratable */
> >> +	.init = trusted_caam_init,
> >> +	.seal = trusted_caam_seal,
> >> +	.unseal = trusted_caam_unseal,
> >> +	.exit = trusted_caam_exit,
> >> +};
> > caam has random number generation capabilities, so it's worth using that
> > by implementing .get_random.
> 
> If the CAAM HWRNG is already seeding the kernel RNG, why not use the kernel's?
> 
> Makes for less code duplication IMO.

Using kernel RNG, in general, for trusted keys has been discussed
before.   Please refer to Dave Safford's detailed explanation for not
using it [1].

thanks,

Mimi

[1] 
https://lore.kernel.org/linux-integrity/BCA04D5D9A3B764C9B7405BBA4D4A3C035F2A38B@ALPMBAPA12.e2k.ad.ge.com/
 

