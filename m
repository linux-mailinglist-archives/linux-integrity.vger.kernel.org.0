Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DE73C8897
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Jul 2021 18:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhGNQ21 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Jul 2021 12:28:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65254 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229607AbhGNQ21 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Jul 2021 12:28:27 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16EG3fZI089186;
        Wed, 14 Jul 2021 12:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=yPrLxmnyOnxR1pz5OQFVUWGEI3TM6e8GazDGcEmCaPs=;
 b=k2wcC4bg4hQ3HEoj9QBmeSkvJHuA4pSQDvxM4a49sHj6nyagSkePRBkQfUniyG3iDnWu
 N/c/2S8bS+t2/GUe2MBpyiB49sYtrH/a5T/Ogvy0lOUkKOa1OVvN9JkBAGuJ0sI4ysHs
 9DobV3ls9gwDwn/8hwjqfYx8wBT3qiW8TxRyni1ByEcQRjBq0+rAKKMUg9kfe/04Fof2
 o8whcb6OZlqPN6veR3Pj1ZYnaiNjPV9UkMsY0i4JY0Dt0veS6vk39zNpjs3YZucqw9WU
 TAR5y94RP3G+GHWKUuLqBQqzyW1WxFabpWFHlLjFt5A0RKFCPruY/V9AhJElRBKs3YG8 Cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39sc8k9dh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jul 2021 12:25:33 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16EG4P1X095857;
        Wed, 14 Jul 2021 12:25:32 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39sc8k9dga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jul 2021 12:25:32 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16EGFQ9h022891;
        Wed, 14 Jul 2021 16:25:30 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 39q3688yyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jul 2021 16:25:30 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16EGPRf727263428
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jul 2021 16:25:27 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 758B952057;
        Wed, 14 Jul 2021 16:25:27 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.127.85])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6E68C52054;
        Wed, 14 Jul 2021 16:25:26 +0000 (GMT)
Message-ID: <f79c51848838d43214a6d23761aaae88573473c1.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils 1/3] CI: Do not install swtpm if it cannot
 work anyway
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Wed, 14 Jul 2021 12:25:25 -0400
In-Reply-To: <20210712051644.2469633-1-vt@altlinux.org>
References: <20210712051644.2469633-1-vt@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BYbKl-ImLqehX5Ps73qL2eLcjOgJaQi8
X-Proofpoint-ORIG-GUID: Mf9rqAhEu3AgI5kN--hHjG5aboYlPMNx
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-14_08:2021-07-14,2021-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107140096
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-07-12 at 08:16 +0300, Vitaly Chikunov wrote:
> Do not need to waste CPU cycles and time to install swtpm in CI
> container if distribution does not have tssstartup, because we will
> be not able to start it.
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>

Thanks!  This and the other two patches are queued in next-testing (sf,
github).

Mimi

