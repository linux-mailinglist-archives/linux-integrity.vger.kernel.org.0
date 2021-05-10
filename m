Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104D83792ED
	for <lists+linux-integrity@lfdr.de>; Mon, 10 May 2021 17:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhEJPmS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 May 2021 11:42:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55868 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230002AbhEJPmN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 May 2021 11:42:13 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14AFXAhf070252;
        Mon, 10 May 2021 11:41:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=2x1xRo5uCNmSUaQsOyJrca3z7VNagyAI9mU+aKr7H+I=;
 b=MgHz4GPfulJUUEefaDYWx87eeoR1AYyZygrt/jLefl/i63TNrXa2hkKiZ/mGafbpcf0K
 qiNvz93J84nSN/Cf5ml5tww2M8V32Zi0pWBgtFFG0K1G6O0OoANo/SKYNX2aM3J810pV
 JwsNrk3A8kAYErSKpLCcC2Zo1CiRto2jfeOelJCw1zbRJI/HFbTDhdR5Ysdm2+Vk6bQt
 +mwDnkpNC0ikW23thkaAb8VtO5jwhV7Pfo1feHo/KuWVUihOdB53QItr3P103pXvP9Hl
 RZn/77PouNXsI8H7CjKGeI8qqMYX/P54JwhfhL7PIAUvbEAMgZCH+yyB+T4y/MjcEDWF pg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38f6683k3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 May 2021 11:41:02 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14AFYBMm077630;
        Mon, 10 May 2021 11:41:01 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38f6683k2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 May 2021 11:41:01 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14AFXqJV015563;
        Mon, 10 May 2021 15:40:59 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 38dj9892kc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 May 2021 15:40:59 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14AFeU2V27263290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 15:40:30 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34C0011C050;
        Mon, 10 May 2021 15:40:57 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F216211C04C;
        Mon, 10 May 2021 15:40:55 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.108.89])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 10 May 2021 15:40:55 +0000 (GMT)
Message-ID: <5ce38d9a4e1e65c0c6546429c14944645072d11a.camel@linux.ibm.com>
Subject: Re: [PATCH v2 0/3] ima-evm-utils: Implement function to only create
 IMA signature
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>
Cc:     dmitry.kasatkin@gmail.com
Date:   Mon, 10 May 2021 11:40:55 -0400
In-Reply-To: <94771a1d-c48e-3773-8f1f-282519648a73@linux.ibm.com>
References: <20210427193133.1718367-1-stefanb@linux.ibm.com>
         <94771a1d-c48e-3773-8f1f-282519648a73@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FFCmbKDq-uHP1RVqn4W91bxkELH6v4vQ
X-Proofpoint-ORIG-GUID: 26Vs9CvjDKyANvShVkra6CweNYg0sEch
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-10_09:2021-05-10,2021-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 mlxscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105100110
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Stefan, Vitaly,

On Mon, 2021-05-10 at 09:55 -0400, Stefan Berger wrote:
> I will rebase this series of patches on Vitaly's keyid-related changes, 
> which are good to have 'underneath'.

Sorry for the delay in reviewing/commenting on your patch sets.  
Hopefully I'll be circling back around to ima-evm-utils later this
week, after staging Roberto's EVM kernel patch set.  Vitaly, I noticed
that your patch set doesn't apply cleanly to next-testing.   I haven't
taken the time to figure out why yet.

thanks,

Mimi

