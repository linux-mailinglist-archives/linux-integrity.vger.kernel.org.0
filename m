Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2503685D0
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Apr 2021 19:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236667AbhDVRYx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Apr 2021 13:24:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33152 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236287AbhDVRYx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Apr 2021 13:24:53 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13MH3774152386;
        Thu, 22 Apr 2021 13:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ny6eUa2pWJaAztEFaaCjx4Af+2Iip1DFJY/+o/Lyygs=;
 b=cE5pVCiI9SYqc9Wc5Llw0OuuvHycQBGUGl6vOn2HGAkivg2ctlfQtgQJsnCJOAsmCRgr
 B8lPmA+DsMO4ZLgqetPyVmQMAwQT+k+ZxMlQLhFOInbmMJyoQq8eynV6327gmFhhQ4lc
 P8YZrru1m2eHgz+pjVzYy/hGVteiYM+k78q7c5UbpVEvH0N1Z0aR3cYd/RcNzbrMqnwA
 h+KhFUaR/gD8K8DykG0YHpm5LXXji77n1iX3XA2XPqVBo2c7ml7tP9X31e8wLEV9vbS0
 Z/91XvjHT9Wg/WOHfhKnftluTkb43EuyQef71aC71KsUmChb/Yoht7VvWQYXrsGMOewm 7w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3838n6tcjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 13:23:39 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13MH45Ou156570;
        Thu, 22 Apr 2021 13:23:39 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3838n6tcj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 13:23:39 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13MHGt2Q003591;
        Thu, 22 Apr 2021 17:23:38 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma05wdc.us.ibm.com with ESMTP id 37yqa9kd7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 17:23:38 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13MHNbbc17301872
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 17:23:37 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5562112405B;
        Thu, 22 Apr 2021 17:23:37 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42CAF124052;
        Thu, 22 Apr 2021 17:23:33 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com (unknown [9.211.42.66])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 22 Apr 2021 17:23:32 +0000 (GMT)
Subject: Re: [PATCH] ima: require CONFIG_MODULES for IMA_APPRAISE_MODSIG
To:     Arnd Bergmann <arnd@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        John Johansen <john.johansen@canonical.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Bruno Meneguele <bmeneg@redhat.com>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210422132956.1628059-1-arnd@kernel.org>
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <2fd688d8-9f39-5839-2262-fb703d19d4c3@linux.vnet.ibm.com>
Date:   Thu, 22 Apr 2021 13:23:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210422132956.1628059-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 86X-afWF5ijgDGXQ3Si7BegMd0btkpNR
X-Proofpoint-ORIG-GUID: gYy4mficW60_jMLR9n-_9DqqdirzbrSf
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-22_12:2021-04-22,2021-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 clxscore=1011
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104220128
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 4/22/21 9:29 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> When module support is disabled, CONFIG_MODULE_SIG_HASH cannot
> be set either, so the build process fails with an error
>
> certs/Makefile:52: *** Could not determine digest type to use from kernel config.  Stop.
>
> when IMA_APPRAISE_MODSIG is set but modules are not.
>
> Add a Kconfig dependency to prevent this configuration.
>
> Fixes: 0165f4ca223b ("ima: enable signing of modules with build time generated key")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd !!

This fix solves the config issue, but adds an unnecessary MODULES 
dependency on APPRAISE_MODSIG. APPRAISE_MODSIG can be used for kernel 
image(appended signature) as well as for kernel modules.

I am working on the fix. I am sorry for the delay, I got stuck with some 
urgent issues early this week.

Thanks & Regards,

       - Nayna

