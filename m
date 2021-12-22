Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7888047D59A
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Dec 2021 18:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344215AbhLVRKU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Dec 2021 12:10:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45352 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230314AbhLVRKU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Dec 2021 12:10:20 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BMH7aYb015224;
        Wed, 22 Dec 2021 17:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=nYaXQipwzETt4J2rtE2uBsqHuGhd71QhvpT8TF2KJoc=;
 b=fViTgUrMjWUyyDemDf7e8hS1ZE/jfkMPYJLIuIf8fhbU8qS6VLHFUEIHBblAZFS8/tFb
 Ul7q0TiD6x3KfvRxcjBhJWsh4MuV7oaVMgXowhOiPCVx8HHmES8Wi2EvFzg9V5E/GSCI
 Id7BVE9kyIT2RocdexlEJVrCUrOAa3k4qbCoZdRfAu/u3EmFEjpIJUkYF4zOADofx886
 DA4qxx0ddHuACGDX/StCWdfUHmBatMYgp8bn+TKpZSfOVTjVXMSvyYErIkJ+/F9HEQ3h
 5Yg+1AxHAngD/tjX7mF3TmY14FfA7ps/1US83qh6dwI/oiaHAZcdWbZgHVxi3hY3mjhY SQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d3eu0n14y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 17:10:12 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BMH9k3t022820;
        Wed, 22 Dec 2021 17:10:12 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d3eu0n14a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 17:10:11 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BMH6w0Y031802;
        Wed, 22 Dec 2021 17:10:10 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3d16wk0r4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 17:10:10 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BMHA7Uj38011198
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Dec 2021 17:10:07 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5774F4204C;
        Wed, 22 Dec 2021 17:10:07 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D01342041;
        Wed, 22 Dec 2021 17:10:06 +0000 (GMT)
Received: from sig-9-65-92-34.ibm.com (unknown [9.65.92.34])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 Dec 2021 17:10:06 +0000 (GMT)
Message-ID: <be59880bb5be18207eeb91b920f43d05fa3a1dd2.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Fix undefined arch_ima_get_secureboot() and co
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Takashi Iwai <tiwai@suse.de>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joey Lee <jlee@suse.com>
Date:   Wed, 22 Dec 2021 12:10:05 -0500
In-Reply-To: <20211213161145.3447-1-tiwai@suse.de>
References: <20211213161145.3447-1-tiwai@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: v1bcwv8vK7ETddMYAENsVSGHDYsb3GsG
X-Proofpoint-ORIG-GUID: XVnzW0x1qWZXJpje5DQvVLpO_ZFcVFC7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-22_07,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 phishscore=0 mlxlogscore=963 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112220096
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Takashi,

On Mon, 2021-12-13 at 17:11 +0100, Takashi Iwai wrote:
> Currently arch_ima_get_secureboot() and arch_get_ima_policy() are
> defined only when CONFIG_IMA is set, and this makes the code calling
> those functions without CONFIG_IMA failing.  Although there is no such
> in-tree users, but the out-of-tree users already hit it.
> 
> Move the declaration and the dummy definition of those functions
> outside ifdef-CONFIG_IMA block for fixing the undefined symbols.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Joey's patch has a dependency on your patch, as seen by the kernel test
robot report.  I'll drop the one line referencing in-tree/out-of-tree
sentence in the patch description, before picking it up as well.

thanks,

Mimi

