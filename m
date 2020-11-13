Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78CDE2B1F56
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Nov 2020 16:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgKMP5Y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Nov 2020 10:57:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35612 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726741AbgKMP5X (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Nov 2020 10:57:23 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ADFfpe3053436;
        Fri, 13 Nov 2020 10:57:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=6Bma8JVVvotebU2sHjOCW2Bu+52hzHJBheh7pWVE0Ow=;
 b=tS9sH5Gg7MoMpcQ6luqe//kA0Cl0YCoDfkBP+jHvzeScizXTIa3tLyVD8ajQrmk79BNu
 II5L775mnYNBJ5wmZ6LxO/+G5+W+nAiqXYVhXTd4qbiO5noi9s0e0jEz24CwON7wdR09
 LoVqSqq87rRHa9WdMqY+IADeXmyrCScoXrTAMedcmm+cBaBt4IuSMvoFIriFP1gBj7Q6
 u3Oepq0aOzhWGpJtjYcB0LIPupbDIB064MwhGnFWYNGv4GhVNFal9xkPY6RNng3GXXmQ
 PPlcqUU830UH550O0p6qykFDK0ybLoYcaRM3hA/mZUy/sdKgdaDyQpQdHSF6geUzR1MU tQ== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34sw0v8exm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Nov 2020 10:57:20 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0ADFrVP1012531;
        Fri, 13 Nov 2020 15:57:19 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 34nk77ug7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Nov 2020 15:57:18 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0ADFvGnu3670690
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Nov 2020 15:57:16 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 943CCAE04D;
        Fri, 13 Nov 2020 15:57:16 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53044AE055;
        Fri, 13 Nov 2020 15:57:15 +0000 (GMT)
Received: from sig-9-65-233-212.ibm.com (unknown [9.65.233.212])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 13 Nov 2020 15:57:15 +0000 (GMT)
Message-ID: <27ecba12eb9f61e73b4b3ecf69310ce3f21bc2e9.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ima: select ima-buf template for buffer measurement
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     tusharsu@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:57:14 -0500
In-Reply-To: <20201112203959.3657-1-nramas@linux.microsoft.com>
References: <20201112203959.3657-1-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-13_10:2020-11-13,2020-11-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=3 mlxscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011130096
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,

On Thu, 2020-11-12 at 12:39 -0800, Lakshmi Ramasubramanian wrote:
> The default IMA template used for all policy rules is the value set
> for CONFIG_IMA_DEFAULT_TEMPLATE if the policy rule does not specify
> a template. The default IMA template for buffer measurements should be
> 'ima-buf' - so that the measured buffer is correctly included in the IMA
> measurement log entry.
> 
> With the default template format, buffer measurements are added to
> the measurement list, but do not include the buffer data, making it
> difficult, if not impossible, to validate. Including 'ima-buf'
> template records in the measurement list by default, should not impact
> existing attestation servers without 'ima-buf' template support.
> 
> Initialize a global 'ima-buf' template and select that template,
> by default, for buffer measurements.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

Thanks!  It's now queued in next-integrity-testing.

Mimi

