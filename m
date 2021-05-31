Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA893964F0
	for <lists+linux-integrity@lfdr.de>; Mon, 31 May 2021 18:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhEaQRm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 May 2021 12:17:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22128 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234423AbhEaQOi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 May 2021 12:14:38 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14VG39Ix176367;
        Mon, 31 May 2021 12:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=2I00Li2bPAoimjrwNBkE47RCTeR4TNTbIlgHwq4dQMQ=;
 b=ePBNJOVI2MhyrnfX2UMx3Uuuv+qZW6iP0p32oLd3xzUxcNNxcnP5rkTW96mwvHcXPoWU
 Poj4hSFU78ypfyBzxnK7MgdL7Vk445s19E+Or8jfLpaNGqBnZXlEUviZapS0/+A1TFD/
 2xOC/5fGKKGM+2/7kAtbn8/JuKFalcl6stR8LbfDnuHdY4iFu+ZaETP9TgdC6h7zANit
 qWbz0jBuGR7mHx+49GTEq630oQ8Acuu/P1O6ifQDhHFRyGr+UpU7I1NqSVXPaH6TYT2a
 vSyBICn2gRWnW+k1h2FWysHIlgFCt1v7kSbz4AOjs8HM9EBz4/aNuXEjKPzJngtuixWr rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38w2ers0rr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 May 2021 12:12:55 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14VG3Zsv181685;
        Mon, 31 May 2021 12:12:54 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38w2ers0qk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 May 2021 12:12:54 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14VGBuwF024973;
        Mon, 31 May 2021 16:12:51 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 38ud8894s4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 May 2021 16:12:51 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14VGCmnH28180800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 May 2021 16:12:48 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5944AA4064;
        Mon, 31 May 2021 16:12:48 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D587A405F;
        Mon, 31 May 2021 16:12:46 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.84.117])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 31 May 2021 16:12:46 +0000 (GMT)
Message-ID: <e5baf1bbc6aa454c2a708d85d73fdc2f3470bf16.camel@linux.ibm.com>
Subject: Re: [PATCH v4 2/2] certs: Add support for using elliptic curve keys
 for signing modules
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>, jeyu@kernel.org,
        keyrings@vger.kernel.org, dhowells@redhat.com, jarkko@kernel.org
Cc:     nayna@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 31 May 2021 12:12:35 -0400
In-Reply-To: <20210423151247.1517808-3-stefanb@linux.ibm.com>
References: <20210423151247.1517808-1-stefanb@linux.ibm.com>
         <20210423151247.1517808-3-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0pi9Cw8l3rZcCOJaNPzg2fuGX6YwFQZk
X-Proofpoint-GUID: dt0a-cCF-gfTM2cxMStyqLjtWLubRTMy
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-31_10:2021-05-31,2021-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105310119
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-04-23 at 11:12 -0400, Stefan Berger wrote:
> Add support for using elliptic curve keys for signing modules. It uses
> a NIST P384 (secp384r1) key if the user chooses an elliptic curve key
> and will have ECDSA support built into the kernel.
> 
> Note: A developer choosing an ECDSA key for signing modules should still
> delete the signing key (rm certs/signing_key.*) when building an older
> version of a kernel that only supports RSA keys. Unless kbuild automati-
> cally detects and generates a new kernel module key, ECDSA-signed kernel
> modules will fail signature verification.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Tested-by: Mimi Zohar <zohar@linux.ibm.com>

