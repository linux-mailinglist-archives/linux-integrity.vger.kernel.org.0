Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D400F3CBECA
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Jul 2021 23:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235785AbhGPWBV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Jul 2021 18:01:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12322 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230490AbhGPWBT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Jul 2021 18:01:19 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16GLXZ2q027914;
        Fri, 16 Jul 2021 17:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=kJwi4ZFvcota5soCszAJtYVrFijtjZximILdujdKR4k=;
 b=czb8gJV4qydzAo78eG7bbTI0x9HwFjnoibNYRZqtjquHhjjYaj7oxpXAdOEkRUro6gW5
 eUANrDxxxDPukBIATjBnL9PX2JQbtJotvs4MOjx4rN1xiwZbqW7lTPsSsXmDhE7Xaa1u
 FzE4k5aYm6Wn+Z0gw83JEiQOLnMPlBWo/jlbwkv9b736BmWlscena0YhZOjG5NLKqF+h
 eMIVlkSixWFyhZ6sBKdhVnv1MfKHfv9OtglOzUKcgKJBuwwVtzTArn7k7i4JEJ7uHSKC
 y4oSt4Jyu8DFfuTzpdaoUCxBus9op2khPfP2XnG7RXJwk6FOiM1y2azSr47UgTcAysmv 9A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39twuxr4vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jul 2021 17:58:22 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16GLZCZb030887;
        Fri, 16 Jul 2021 17:58:21 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39twuxr4v8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jul 2021 17:58:21 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16GLwJGU025437;
        Fri, 16 Jul 2021 21:58:19 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 39q3689j5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jul 2021 21:58:19 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16GLwHGY21627240
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jul 2021 21:58:17 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9A1752051;
        Fri, 16 Jul 2021 21:58:16 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.55.33])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 159E55204F;
        Fri, 16 Jul 2021 21:58:15 +0000 (GMT)
Message-ID: <5d666583a9dab368f68414e18618665ba479b8d3.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v3] CI: Add support for ALT Linux
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Fri, 16 Jul 2021 17:58:15 -0400
In-Reply-To: <20210715204728.3472552-1-vt@altlinux.org>
References: <20210715204728.3472552-1-vt@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _qHzOy7OP1rLAUfsaU0c9q2dng5Kj8yq
X-Proofpoint-GUID: aCj1KhZrQOJyjJL4kwFIoivo5kD8pJ-T
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-16_10:2021-07-16,2021-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107160136
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-07-15 at 23:47 +0300, Vitaly Chikunov wrote:
> Build on Sisyphus branch which is bleeding edge repository.
> Package manager is apt-rpm (not APT as it may look from the scripts).
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>

Thanks, applied to next-testing.   (Replacing the existing patch caused
a forced update.)

Mimi

