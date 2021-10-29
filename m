Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A093343F4B4
	for <lists+linux-integrity@lfdr.de>; Fri, 29 Oct 2021 03:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhJ2CAp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 28 Oct 2021 22:00:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17676 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231460AbhJ2CAo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Oct 2021 22:00:44 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19T1JENo016532;
        Fri, 29 Oct 2021 01:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=H+A++g3sh16LWEuk04HpfWd6aeStlTzW+K+a9B31kb4=;
 b=Sxt5P8FycLXnVlFg++czvjjS+0P37g3gzyx7Ukhyd786VXbnKjqJUZDq1RAwNcb22QS3
 Trf3XLBE3m171ZLQ0Es9N7Gv646Ot1BkCEbUcnkWNcUgO/h0qup9bY+99Os++8+7wCi2
 VnngRrwXlITvaaAy+5/yZuDHK6XoD/xrXgA6uQowq1kzoifB0bj96ZRxlw2W2p/CDXxO
 +1yLzGUUQyrrYhA9BhtjgmgANrfs6Yg2TIlUkG3W/pGU4j3zL672al3TYj8RR0JZa8pL
 hy9RLQhDvam3VTFEOcVk3qoc4uhFCGCCAOsSirHtKM+aN9JBRXLdS9+BtsHloCuhh1u2 NA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c076a8hh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Oct 2021 01:58:04 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19T1i9cY009590;
        Fri, 29 Oct 2021 01:58:04 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c076a8hgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Oct 2021 01:58:04 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19T1qioS028720;
        Fri, 29 Oct 2021 01:58:02 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3bx4etpe02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Oct 2021 01:58:01 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19T1vxX93539570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Oct 2021 01:57:59 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72D53A405C;
        Fri, 29 Oct 2021 01:57:59 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 799BEA405B;
        Fri, 29 Oct 2021 01:57:58 +0000 (GMT)
Received: from sig-9-77-156-188.ibm.com (unknown [9.77.156.188])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Oct 2021 01:57:58 +0000 (GMT)
Message-ID: <8dfbb3ee3330f8049a124dde62717d5363534922.camel@linux.ibm.com>
Subject: Re: [PATCH] evm: mark evm_fixmode as __ro_after_init
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Austin Kim <austindh.kim@gmail.com>, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, austin.kim@lge.com
Date:   Thu, 28 Oct 2021 21:57:57 -0400
In-Reply-To: <20211028112642.GA1110@raspberrypi>
References: <20211028112642.GA1110@raspberrypi>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KuO-akf0hj7-KbYKtpx-C8QodN_X9wRM
X-Proofpoint-ORIG-GUID: URBpEN-X3r5UDRQWomqt0VUpsnlsVUdQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-28_06,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=781 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110290007
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-10-28 at 12:26 +0100, Austin Kim wrote:
> From: Austin Kim <austin.kim@lge.com>
> 
> The evm_fixmode is only configurable by command-line option and it is never
> modified outside initcalls, so declaring it with __ro_after_init is better.
> 
> Signed-off-by: Austin Kim <austin.kim@lge.com>

Thanks, Austin.  This patch set is now applied to the next-integrity
branch.

Mimi

