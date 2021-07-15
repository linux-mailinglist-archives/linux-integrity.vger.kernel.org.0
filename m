Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E0F3CA057
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Jul 2021 16:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhGOOQf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Jul 2021 10:16:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64058 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229457AbhGOOQf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Jul 2021 10:16:35 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16FE6ZgG138562;
        Thu, 15 Jul 2021 10:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=fLMXWAaB59YHfbyl/hONrFMCEGIxYm9MagYmNOoRkMM=;
 b=bCSqKA7MZ+dp1xIMuit7IBDfM9SUAwJI6nxVOSoT8W6LrfAtUNaou7yKxa5mTPBB3jTA
 1uq8nofDA6Ssd50hsO+6LzElz5osesWzjTVfVuCb5dt5uAIAA3rz+7w9AyrL0BtPWm55
 VFRpsBu34ec8IS6kq6BSvkGnMirNH+bvVc/lHyw2bIxqWak1O0hLEiUYl9c/1D2IUZDh
 7G6hK9TPpidJdaqtaM5ux3Jkp4MX7W7o5h0QbXwIm9hJlO0OB7+UYOpxwTQPJ9LWjx6g
 chgnKwA9pw9XIYPA8mVoOs5JDbKU2xzIHbdlFXeQX8XpeIQSFFoqnzgfiMGZU71dDC32 QA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39sc3065j9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jul 2021 10:13:39 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16FE6jT1139599;
        Thu, 15 Jul 2021 10:13:39 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39sc3065he-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jul 2021 10:13:39 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16FEAFLC032426;
        Thu, 15 Jul 2021 14:13:37 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 39q36897gb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jul 2021 14:13:37 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16FEDZQl24052064
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jul 2021 14:13:35 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40D4AAE053;
        Thu, 15 Jul 2021 14:13:35 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53299AE04D;
        Thu, 15 Jul 2021 14:13:34 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.117.215])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 15 Jul 2021 14:13:34 +0000 (GMT)
Message-ID: <61ae65878d75abb64d0b7e24e8d6a93ecb00f6fa.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v2] CI: Add support for ALT Linux
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Thu, 15 Jul 2021 10:13:33 -0400
In-Reply-To: <20210715124334.3319281-1-vt@altlinux.org>
References: <20210715124334.3319281-1-vt@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0VNM7kMRwj_Ds9fptnoulWXUqU7CthIo
X-Proofpoint-ORIG-GUID: swxQqUgDgnLjlVa1jPEugjz1yImeIhSz
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-15_10:2021-07-14,2021-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107150100
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-07-15 at 15:43 +0300, Vitaly Chikunov wrote:
> Build on Sisyphus branch which is bleeding edge repository.
> Package manager is apt-rpm (not APT as it may look from the scripts).
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
> Chnges from v1:
> - Fix skipping of gost algo tests.

Thanks, now in next-testing.

Mimi

