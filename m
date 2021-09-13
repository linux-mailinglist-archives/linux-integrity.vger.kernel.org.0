Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD74E409A15
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Sep 2021 18:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbhIMQzX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Sep 2021 12:55:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21612 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239512AbhIMQzW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Sep 2021 12:55:22 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18DGZbZq006007
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 12:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=steAjPX6UtZ/r0j3e+Ear+ZiJcrep8KroXRMaNzT2jA=;
 b=HwaKo79cl6qr1ENL9C4JRwuHkWiZnjnx9g9Qkir32Lvz2i7E7Zxgdt2DkXCeVOO3WP/X
 kW4GXdMEI33F7neKohBdMdpmzsBgMV3iV14FLnXXQQ/uvHwjAGD4dW7polWleJfgn0MB
 mb/bvKP0tl5FVD9oRKO2d26YUQGJ48c/YsZaSwU2cFWEKR06oc2T0+m8J6N9rX9bSJOH
 f67H3Hc1+YOV8/s29iqGklpWtxGblAdvMtlWYj7vRQ/dTGx7LMIoIW/sT4Q8oMUvFJOx
 A6zW+tUuhcOrhmoz+PyZg0cPWYSfX/gjPgD9/12SofDZK04GArdhcRaG945NsVMHtpoW yQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b2aa5rae7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 12:54:05 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18DGrJZC014851
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 16:54:03 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3b0m39jyvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 16:54:03 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18DGs0A448103790
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Sep 2021 16:54:00 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 582F042047;
        Mon, 13 Sep 2021 16:54:00 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8450A4204D;
        Mon, 13 Sep 2021 16:53:59 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.27.52])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 13 Sep 2021 16:53:59 +0000 (GMT)
Message-ID: <894c3656b59bfc7b9581ba1606e4129e7af7cc96.camel@linux.ibm.com>
Subject: Re: [PATCH v3 0/9] ima-evm-utils: Add support for signing with
 pkcs11 URIs
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     Stefan Berger <stefanb@linux.ibm.com>
Date:   Mon, 13 Sep 2021 12:53:58 -0400
In-Reply-To: <20210908192343.4147739-1-stefanb@linux.vnet.ibm.com>
References: <20210908192343.4147739-1-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5MaylyU5Vc47sytuCIHBgCexeuz8i1Lr
X-Proofpoint-ORIG-GUID: 5MaylyU5Vc47sytuCIHBgCexeuz8i1Lr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109130102
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-09-08 at 15:23 -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>

Having a "From: " line normally occurs when the original author is
being credited with the patch, but the patch is being updated/modified
by someone else.

> 
> This series of patches adds support for signing with pkcs11 URIs so that
> pkcs11-enabled devices can also be used for file signing.
> 
> A test program is provided setting up SoftHSM for test cases to use. I added
> two test cases for testing with SoftHSM.

The correlation between the first paragraph and the second is
missing.   The second paragraph also needs to be written in the 3rd
person.  Perhaps say something like, "Extend the existing
sign_verify.test with tests for the new pkcs11 URI support.  Use the
SoftHSM, when available, as the pkcs11 device."

thanks,

Mimi

