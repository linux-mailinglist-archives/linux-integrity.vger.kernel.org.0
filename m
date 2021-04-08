Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB73358B26
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Apr 2021 19:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhDHRPm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Apr 2021 13:15:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29772 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231566AbhDHRPl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Apr 2021 13:15:41 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 138H31Zw190509;
        Thu, 8 Apr 2021 13:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=3cvybI0LmyDrt5g7fMGhCTVmRJAdvGLg6mTcxjsQ0rU=;
 b=s4uWPVt7aNhGxTr/vqgGnvXgF7ZN+LSgFw11OqNmt+42pGVunCykfyrShGkOkStV/GaS
 II5AB1tZI5rOVUS+qCG5w/EIX0rSDtDwO9P2JOIARc5e3nfF2rfK2GYdC5Ut4bRktfwV
 Daf6/MDE8hHlDC+eWKgBMIUeFJU0jBVlTEC5IIQFqFJarY1hv8Bso0OE8rZHHlo25ueN
 VvHBhHf81dTkcQFxUp3UTXGNtdZwuWdCdeC2Hf508nOhKiNXD5gp/8zg1Dtt8XTfDWCM
 0uNIdkpfndJB9rZj7wsNzyBdguz5iLZu/6XHqUj3gcSI4b9eb0m1kf+GoxXUcME1aOC/ ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37s5xtpddv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 13:15:28 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 138H3avl193641;
        Thu, 8 Apr 2021 13:15:27 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37s5xtpddd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 13:15:27 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 138H1Q6Z032308;
        Thu, 8 Apr 2021 17:15:25 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 37t3h8g3ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 17:15:25 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 138HFMfP50921876
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Apr 2021 17:15:23 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D135FA4BC3;
        Thu,  8 Apr 2021 17:15:22 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE429A4BBF;
        Thu,  8 Apr 2021 17:15:20 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.65.12])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  8 Apr 2021 17:15:20 +0000 (GMT)
Message-ID: <97602f56163f9de0afade56c4305ea297db4a941.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/2] certs: Add support for using elliptic curve keys
 for signing modules
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>, keyrings@vger.kernel.org,
        dhowells@redhat.com, jarkko@kernel.org
Cc:     nayna@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 08 Apr 2021 13:15:19 -0400
In-Reply-To: <20210408152403.1189121-3-stefanb@linux.ibm.com>
References: <20210408152403.1189121-1-stefanb@linux.ibm.com>
         <20210408152403.1189121-3-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KNQbOmF215-j6k7HqKTJ6WdAj4Z6BeoG
X-Proofpoint-ORIG-GUID: UUhICsa45CoImORi5XCp4jpF1YiB_boi
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-08_04:2021-04-08,2021-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 impostorscore=0 mlxlogscore=999
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104080110
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-04-08 at 11:24 -0400, Stefan Berger wrote:
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

Thanks, Stefan.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

