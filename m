Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B86255981
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Aug 2020 13:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgH1Lkh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 Aug 2020 07:40:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37038 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729266AbgH1LiN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Aug 2020 07:38:13 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07SB4wsM171945;
        Fri, 28 Aug 2020 07:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ChqKJdfWFRoYc5pIm+wNrKOa++94seoc95Wb7qC/dHk=;
 b=H8nVBkr91T0PXSRCE+VLeAM+eOuvIvwgUNWee8N9jA5gxrUn+mdL4/3SlfF4H8aN8rtj
 MFwgyyGjQsMHA8MmW7zXHqSX+g6yiS1muIx7sFM/kv6LHCgtfXU+wy4BxEvhVqEaqUg7
 8lYnq8d+mWMqSBLVBcm449qc/jJZ7HyFmWu6ZzPNG/jGIfdetLD64adW+rxEsAth1Pse
 nTiEuaQcHVfo1XYDuXhpgf3HQrDwxmmbXDp+73UUuab8SA1Xsc3gyiehhQqITXeZ2BvA
 x9ZhL3uDkA4oAd1vMv+OA7HTjR8QbHUB4VKbNf+k2hPyfXo22oZwR2b21PMtctqg0K3I fw== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 337024hd1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Aug 2020 07:19:41 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07SBHm8O016413;
        Fri, 28 Aug 2020 11:19:39 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 335j271je3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Aug 2020 11:19:39 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07SBJb8Q30605616
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Aug 2020 11:19:37 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47836A405C;
        Fri, 28 Aug 2020 11:19:37 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F11AA405B;
        Fri, 28 Aug 2020 11:19:35 +0000 (GMT)
Received: from sig-9-65-214-13.ibm.com (unknown [9.65.214.13])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 Aug 2020 11:19:35 +0000 (GMT)
Message-ID: <3c720a7060a846088f8e60ce8b5c032467e97f23.camel@linux.ibm.com>
Subject: Re: [LTP v4 4/5] IMA: Add a test to verify measurement of
 certificate imported into a keyring
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     ltp@lists.linux.it, Lachlan Sneff <t-josne@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Date:   Fri, 28 Aug 2020 07:19:34 -0400
In-Reply-To: <20200828060554.GB15251@dell5510>
References: <20200820090824.3033-1-pvorel@suse.cz>
         <20200820090824.3033-5-pvorel@suse.cz>
         <b58057275ecdc06bb512d39ea46118197f33c33f.camel@linux.ibm.com>
         <20200827132354.GA20439@dell5510> <20200827135503.GA11990@dell5510>
         <b72657042d13f9b8f30d5bdea7e2d06835e4a1d1.camel@linux.ibm.com>
         <20200827225417.GA29921@dell5510>
         <d6087ee43d18605ee6cdc6b80450b0024af14fb6.camel@linux.ibm.com>
         <20200828060554.GB15251@dell5510>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-28_06:2020-08-28,2020-08-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 impostorscore=0 suspectscore=3 clxscore=1015 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0 mlxlogscore=705
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008280085
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-08-28 at 08:05 +0200, Petr Vorel wrote:
> BTW there are also plans for reboot support [1] [2], that could be used as
> workaround for configuration without CONFIG_IMA_READ_POLICY=y and
> CONFIG_IMA_WRITE_POLICY=y.

The reboot support could also be used for carrying the IMA measurement
list across kexec and verifying the TPM PCRs.

Mimi

