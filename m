Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3AD836B4CA
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Apr 2021 16:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhDZOYt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Apr 2021 10:24:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63794 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233905AbhDZOYC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Apr 2021 10:24:02 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13QE3lZ9162113;
        Mon, 26 Apr 2021 10:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=eDl6vokEieQ5HXFDFJ2BH60Swqsm2L4ihWAQPaoWAy4=;
 b=JDJ8ubNBAYhPPg+goEUwvBsv1tbnt5cF1VuTZc5BQadGuAk/xtN6w8MRIR+2QGidC8fo
 sH11u2Fj+j9q3XO45cv+vK+ZuKFGdEp2xPpMyP9SKFpx7KUnhWThpM7jbFifXDY+DNrI
 ym2FTAfzH+ba2lS+ITTzm/ygW2WN4+77xAe4LTXVu/jtHO+cFZzHNL0j6BYgmJ1G4p+p
 R9hPZjZlx/6eJ4ItY9nfNPFMJ20etvJ/GN/f5gxY8Hjr6RakHP+kbGvBbbvtS9kAWzKY
 xB//pDtnQhb0H6yCaQLodONbEtBKYZ5rEEzLzqoBTkRfRWnKp/hbXM27qRj3Q83rs4i1 zA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 385xfb9vye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 10:23:13 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13QE47O9163721;
        Mon, 26 Apr 2021 10:23:12 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 385xfb9vxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 10:23:12 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13QENCAl013222;
        Mon, 26 Apr 2021 14:23:12 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 384qdhpamu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 14:23:12 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13QENBjm20185472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Apr 2021 14:23:11 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FFD06E060;
        Mon, 26 Apr 2021 14:23:11 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8AAB6E04E;
        Mon, 26 Apr 2021 14:23:10 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 26 Apr 2021 14:23:10 +0000 (GMT)
Subject: Re: [PATCH v2 4/4] tpm: Only enable supported irqs
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, James.Bottomley@hansenpartnership.com,
        keescook@chromium.org, jsnitsel@redhat.com, ml.linux@elloe.vision,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1619394440-30646-1-git-send-email-LinoSanfilippo@gmx.de>
 <1619394440-30646-5-git-send-email-LinoSanfilippo@gmx.de>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <8bcf04a4-1534-fdd8-f6ec-252cdd69118b@linux.ibm.com>
Date:   Mon, 26 Apr 2021 10:23:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1619394440-30646-5-git-send-email-LinoSanfilippo@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Zac272Oqlbcdpmm8tT5ujBdhsGfPvHrx
X-Proofpoint-ORIG-GUID: intocamSJPvrSaiJ7Ia9k5eUPis7OQWr
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-26_07:2021-04-26,2021-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1011 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104260110
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 4/25/21 7:47 PM, Lino Sanfilippo wrote:
> Do not set interrupts which are not supported by the hardware. Instead use
> the information from the capability query and activate only the reported
> interrupts.
>
> Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


