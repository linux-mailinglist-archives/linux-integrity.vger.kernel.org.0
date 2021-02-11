Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB057319125
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Feb 2021 18:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhBKRd5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Feb 2021 12:33:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28970 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230080AbhBKRbv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Feb 2021 12:31:51 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11BHFcD1001797;
        Thu, 11 Feb 2021 12:30:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=X8cuwiMr09qjFxf3XEBiGBA3KDQWNK0BI9F02bgDVdk=;
 b=ZWehr9KynkzulnULjBvqvXYl3tu9pzBFwv5KZKLBVxZ+e56KoSs6EP7B9ol4sJKKWjE9
 Ntyne4J905/Bn9dUzqz+AwsX2QaV8YtTwItbPUmhngPNeEVj8KUGFuWIJBXDs79bexiD
 3rHrb1wJljzlN64iq5O0X7Hz4A9FMajqlPguB6Ck16LG74gQVQ9o6D6TUN9CBO0cLjEZ
 wYiueS1kugIwYhE55iviHOGsYWj4TPtTNSKXm01UvzHOyroTw8Lic5qWdXhjIONWfLAY
 D+HOqTQ1dlTB+U96VxCOn0dP/DxUKN9ejxUl30pndgFBQSOZyK/breS6YsoUntRXXOj7 JA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36n8tx0dxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 12:30:55 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11BHIsxi011950;
        Thu, 11 Feb 2021 12:30:55 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36n8tx0dw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 12:30:55 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11BHQvLE014523;
        Thu, 11 Feb 2021 17:30:53 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 36hjr9s5a2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 17:30:53 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11BHUqIB41091570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 17:30:52 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57A92124052;
        Thu, 11 Feb 2021 17:30:52 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4477C124058;
        Thu, 11 Feb 2021 17:30:52 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 11 Feb 2021 17:30:52 +0000 (GMT)
Subject: Re: [PATCH v7 3/4] x509: Add support for parsing x509 certs with
 ECDSA keys
To:     kernel test robot <lkp@intel.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, davem@davemloft.net,
        herbert@gondor.apana.org.au, dhowells@redhat.com,
        zohar@linux.ibm.com
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        patrick@puiterwijk.org, linux-integrity@vger.kernel.org
References: <20210201151910.1465705-4-stefanb@linux.ibm.com>
 <202102111531.JYJl0c7G-lkp@intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <b72f396e-fafa-cff3-cee2-a47ac5274dc4@linux.ibm.com>
Date:   Thu, 11 Feb 2021 12:30:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <202102111531.JYJl0c7G-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_07:2021-02-11,2021-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 suspectscore=0 clxscore=1011 spamscore=0 adultscore=0 impostorscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110137
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/11/21 3:03 AM, kernel test robot wrote:
> Hi Stefan,
>
> Thank you for the patch! Yet something to improve:
>
>>> crypto/asymmetric_keys/public_key.c:97: undefined reference to `parse_OID'


So the issue is that  only ASYMMETRIC_PUBLIC_KEY_SUBTYPE is selected in 
this config and the selection of OID_REGISTRY is missing. I am not sure 
whether ASYMMETRIC_PUBLIC_KEY_SUBTYPE should/could select OID_REGISTRY 
or whether that would be wrong... ?


     Stefan

