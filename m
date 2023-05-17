Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB76705C3C
	for <lists+linux-integrity@lfdr.de>; Wed, 17 May 2023 03:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjEQBSo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 May 2023 21:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjEQBSn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 May 2023 21:18:43 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCA9269D;
        Tue, 16 May 2023 18:18:41 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34H17jt8025818;
        Wed, 17 May 2023 01:18:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=KmU7UPnAnSf6c1RNg/uFbRLIxBBlxHBio2SWVAbWWFM=;
 b=kbWjXyzASgiEX9FLUfizn4xO+bz7/O3QPlo7Vb5LXbvLHruiNJHKdImjWUzHk7pAQJEf
 KzIqx+aWe6+MeW7nVfhkNDkWeS/GII0/izK7m90GkWdbPs02dAjLXaKqWutzZ/NIqO4Z
 rkVQvWPp+L3fssSVHg+BTIUyIj3KIJvRdOMqGtUIMcnwRTuxaPgpRPv40HyWjvM5Ijxn
 K8ii4yRFb8EytsGXLltuKR3mPKxxzlt6+G4A8oTJytdpn6DhuOYJG5ogY8r/3lLULQHH
 Waf7ZL+XZ98o0KcPzRg4x5SWNOAHBhIM9o0/9ZWQC5stuqQ52LeFpLSKfIL9whhffPQE sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qmmbu16kb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 01:18:14 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34H1GJC0029300;
        Wed, 17 May 2023 01:18:13 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qmmbu16jw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 01:18:13 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34GLiqVg009219;
        Wed, 17 May 2023 01:18:13 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3qj265k57v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 01:18:12 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34H1IBGG52494720
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 01:18:12 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1C0C5805E;
        Wed, 17 May 2023 01:18:11 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B89C58059;
        Wed, 17 May 2023 01:18:09 +0000 (GMT)
Received: from sig-9-77-133-203.ibm.com (unknown [9.77.133.203])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 17 May 2023 01:18:09 +0000 (GMT)
Message-ID: <d96f5b8ef6f4afdcae1a3be776d10749bf0b4984.camel@linux.ibm.com>
Subject: Re: [PATCH 1/3] KEYS: DigitalSignature link restriction
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, jlee@suse.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Tue, 16 May 2023 21:18:07 -0400
In-Reply-To: <20230508220708.2888510-2-eric.snowberg@oracle.com>
References: <20230508220708.2888510-1-eric.snowberg@oracle.com>
         <20230508220708.2888510-2-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XMO5lPHlzZjAtUWe1T3poojACAQ46MFQ
X-Proofpoint-GUID: PW6OjyfkjRZcuKRr-tKInEv9N3JM2dEP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_14,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 spamscore=0 impostorscore=0 mlxlogscore=975 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170006
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-05-08 at 18:07 -0400, Eric Snowberg wrote:
> Add a new link restriction.  Restrict the addition of keys in a keyring
> based on the key having digitalSignature usage set. Additionally, verify
> the new certificate against the ones in the system keyrings.  Add two
> additional functions to use the new restriction within either the builtin
> or secondary keyrings.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

Thanks, Eric.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

