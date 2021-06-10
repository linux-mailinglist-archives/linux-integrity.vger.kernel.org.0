Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D499F3A2C4C
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Jun 2021 15:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFJNCQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Jun 2021 09:02:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1292 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230526AbhFJNCP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jun 2021 09:02:15 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15ACY8Iu102396;
        Thu, 10 Jun 2021 09:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=eaoMWKibC48ywMBBJLm1Ve95rH5kpz0SL62FgerNIi4=;
 b=dm/W68RURyeUskWx4PLUG5VZiaizheaMVkMyUZ3ubC1RyNb5w2JWctVxqH6Ct5iUnM+T
 uRvTybpKcvHr6ANptGZtB6q0k8ncsdD4k/xOjpgPvHFcPmrtcbdTXOtT2rnMd+SUa+VQ
 NVGvwGa0/tfpeCouhoSMuTTU/083pi+uLUf1+8FaoaL0FsVGzZmB1XGS+6DZyQYOdVBD
 MlS0HsgsDX5ol0OvWNlDCk1McaXc+ZrVmV7Jp49JeUU2AZWfre5bMHZSLbn2jkk7F+oE
 XMejNo+J+Xe8X7CSHAjYxOErLjXUveY7dz42bPu8pv4T/BPqZ7RlXyzr5wuvm5i4G2Kp YQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 393j8f9x66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Jun 2021 09:00:14 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15ACY9Ir104320;
        Thu, 10 Jun 2021 09:00:14 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 393j8f9x56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Jun 2021 09:00:14 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15ACvYfA013223;
        Thu, 10 Jun 2021 12:59:23 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03wdc.us.ibm.com with ESMTP id 3900wa8588-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Jun 2021 12:59:23 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15ACxNe56226718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 12:59:23 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 319F1112075;
        Thu, 10 Jun 2021 12:59:23 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C0C811206F;
        Thu, 10 Jun 2021 12:59:23 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 10 Jun 2021 12:59:23 +0000 (GMT)
Subject: Re: [PATCH v6 0/4] Add support for ECDSA-signed kernel modules
To:     jeyu@kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, zohar@linux.ibm.com, jarkko@kernel.org
Cc:     nayna@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210610125623.1553792-1-stefanb@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <81ab17a5-1b35-17a0-e7c9-102df873ef70@linux.ibm.com>
Date:   Thu, 10 Jun 2021 08:59:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210610125623.1553792-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Cq_DAdgiB_feTJN5nYJ0Ml92zkLF_cEh
X-Proofpoint-GUID: qRJ5koOk8i0St5gTnEG9eo_Xk_vBHBj4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-10_07:2021-06-10,2021-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 malwarescore=0 mlxlogscore=965 mlxscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106100081
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 6/10/21 8:56 AM, Stefan Berger wrote:
>
> v6:
>    - Patch 2/4 is fixing V4's 1/2 and 4/4 is fixing V4's 2/2. Both fixup
>      patches to be squashed.


Jarkko, take 2/4 and 4/4 and squash them into the respective queued 
patches. 1/4 and 3/4 are untouched other than what the rebase did to 3/4.

   Stefan

