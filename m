Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F12445C92
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Nov 2021 00:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhKDXNX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Nov 2021 19:13:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229596AbhKDXNW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Nov 2021 19:13:22 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A4MNYZo030989;
        Thu, 4 Nov 2021 23:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : content-type : mime-version :
 content-transfer-encoding; s=pp1;
 bh=5ROnpmCV1aFR6z1m5OoBTH2lm/C7bVvCF5R8gSHsB1U=;
 b=lIw4x7n+E08ESxS8A7+dIEkCBCM5YBUBYzJobQVDOYyqjtVfy/xQc6l7Fp15qXkP2n9C
 XFjcAMVLhtVfQR5dw+4c8C+NUlwXgXeLl9VCyUn+XAedRqguhrbTaT9vBj14DoBpNRSW
 aGkyHMTUOq8s+yxYTlTO1jqwn5MOfbXQ8wE1rJTsUIbVP1oY2gUvHmMSBS2qg5jdafmz
 ZtUS1jvr6yhW4oR1Vz6wn38v0ZlfBvqr6Y4oJBJnBM1GGl484T8G556b/n5lnKYQDSVN
 C+9ijUnPwQwVYDceEr9Cvh1Hl16QNdGMaPwLJU6pBSxPWT1NrqELuFiW5OA0JuMsQxG+ Sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3c4j3hhj05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Nov 2021 23:10:39 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1A4N1kik012151;
        Thu, 4 Nov 2021 23:10:39 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3c4j3hhhyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Nov 2021 23:10:38 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1A4N91td010705;
        Thu, 4 Nov 2021 23:10:37 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 3c0wpaj24d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Nov 2021 23:10:37 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1A4NAYXU61669880
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Nov 2021 23:10:34 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 795D1A4066;
        Thu,  4 Nov 2021 23:10:34 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3636A405C;
        Thu,  4 Nov 2021 23:10:33 +0000 (GMT)
Received: from sig-9-65-80-116.ibm.com (unknown [9.65.80.116])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  4 Nov 2021 23:10:33 +0000 (GMT)
Message-ID: <9af9143c2c90f1ebae6cc34a7100673332cce1a1.camel@linux.ibm.com>
Subject: ima-evm-utils: version 1.4 released
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity <linux-integrity@vger.kernel.org>
Cc:     Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E. O. Meneguele" <bmeneg@redhat.com>
Date:   Thu, 04 Nov 2021 19:10:33 -0400
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6rfpCbC3Xz1WaAMo0gCQ4pcI14LIQr6P
X-Proofpoint-ORIG-GUID: ducI2hGwNbR42f7Jc-WN1jUQkuXhoG_M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-04_07,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=762 mlxscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111040089
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Please refer to the NEWS file for the short summary and the git history
for details of the ima-evm-utils v1.4 release.

thanks,

Mimi

