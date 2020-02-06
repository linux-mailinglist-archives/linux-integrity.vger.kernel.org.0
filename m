Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1FB5154CEC
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Feb 2020 21:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgBFUZP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Feb 2020 15:25:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25880 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727845AbgBFUZP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Feb 2020 15:25:15 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 016KDlEa060947;
        Thu, 6 Feb 2020 15:22:12 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y0kne6euw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Feb 2020 15:22:12 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 016KEXKf063196;
        Thu, 6 Feb 2020 15:22:12 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y0kne6eu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Feb 2020 15:22:12 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 016KJUhW002391;
        Thu, 6 Feb 2020 20:22:10 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma05wdc.us.ibm.com with ESMTP id 2xykc9qtdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Feb 2020 20:22:10 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 016KM90S34799880
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Feb 2020 20:22:09 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 171E9BE053;
        Thu,  6 Feb 2020 20:22:09 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DE00BE054;
        Thu,  6 Feb 2020 20:22:05 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.160.44.62])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  6 Feb 2020 20:22:05 +0000 (GMT)
Subject: Re: [RFC PATCH 0/2] ima: uncompressed module appraisal support
To:     Eric Snowberg <eric.snowberg@oracle.com>,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com
Cc:     zohar@linux.ibm.com, dhowells@redhat.com, geert@linux-m68k.org,
        gregkh@linuxfoundation.org, nayna@linux.ibm.com,
        tglx@linutronix.de, bauerman@linux.ibm.com, mpe@ellerman.id.au,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200206164226.24875-1-eric.snowberg@oracle.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <5c246616-9a3a-3ed2-c1f9-f634cef511c9@linux.vnet.ibm.com>
Date:   Thu, 6 Feb 2020 15:22:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200206164226.24875-1-eric.snowberg@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-06_03:2020-02-06,2020-02-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 adultscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002060149
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 2/6/20 11:42 AM, Eric Snowberg wrote:
> When booting with either "ima_policy=secure_boot module.sig_enforce=1"
> or building a kernel with CONFIG_IMA_ARCH_POLICY and booting with
> "ima_policy=secure_boot", module loading behaves differently based on if
> the module is compressed or not.  Originally when appraising a module
> with ima it had to be uncompressed and ima signed.  Recent changes in 5.4
> have allowed internally signed modules to load [1].  But this only works
> if the internally signed module is compressed.  The uncompressed module
> that is internally signed must still be ima signed. This patch series
> tries to bring the two in line.

We (Mimi and I) have been trying to understand the cover letter. It 
seems "by internally signed" you are referring to modules signed with 
build time generated keys.

Our interpretation of the cover letter is that IMA originally did not 
support appended signatures and now does. Since the modules are signed 
with build time generated keys, the signature verification still fails, 
as the keys are only available on the .builtin keyring and not the .ima 
keyring.

Lastly, there is nothing in these patches that indicate that the kernel 
modules being compressed/uncompressed is related to the signature 
verification.

Thanks & Regards,

      - Nayna

