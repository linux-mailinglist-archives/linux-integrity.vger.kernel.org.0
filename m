Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F235C468B3D
	for <lists+linux-integrity@lfdr.de>; Sun,  5 Dec 2021 14:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbhLENtf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 5 Dec 2021 08:49:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18564 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234296AbhLENtd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 5 Dec 2021 08:49:33 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B5BpqID012887;
        Sun, 5 Dec 2021 13:45:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=jzT/tAJSsWD3NmD7AyVv5ElgyWFuPszONu9lyp3gYvs=;
 b=b9neRlTZdEFdd/NKf5eHuychFwhjPs1lVaTQdLzLSp9ai+9JXoiJNKse3tWMXcNLPxcn
 AA4haouNIMEo+U6Id3GiMO2l+yAV7szqEB7N9T8ybN3qphIfuNp2RjvY8KzRgaigFRps
 jux6TZ1tdVRWgGOPYwf7tGtyFFGN6rS/rhj5Tjm9+8BO0KOL/KyfwGBIwh+9dlzzeZ0e
 VmX8bqP5RC+Yfx+ISRC8EK4OLCZgrfMdJykEhWhdJSjrLPF+refnPDpx7mf0tjKtCDRK
 SyOdM+Xykcqve/UvplvR32utG8Q9DtKNYbgU9POSMsokvqkqdQA8vho/Qp/DTXBnTgN5 NQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3crvx21230-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 05 Dec 2021 13:45:56 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B5DjtGY028630;
        Sun, 5 Dec 2021 13:45:55 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3crvx2122r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 05 Dec 2021 13:45:55 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B5DikR9017739;
        Sun, 5 Dec 2021 13:45:53 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3cqykhnpbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 05 Dec 2021 13:45:53 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B5DcEnp29491488
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 5 Dec 2021 13:38:14 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EAE494203F;
        Sun,  5 Dec 2021 13:45:50 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BADF342041;
        Sun,  5 Dec 2021 13:45:49 +0000 (GMT)
Received: from sig-9-65-73-15.ibm.com (unknown [9.65.73.15])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  5 Dec 2021 13:45:49 +0000 (GMT)
Message-ID: <61282ef92ad508d34e4444f6983a06804174e0ac.camel@linux.ibm.com>
Subject: Re: [PATCH v5 2/2] integrity: support including firmware
 ".platform" keys at build time
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, jarkko@kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
        Seth Forshee <seth@forshee.me>
Date:   Sun, 05 Dec 2021 08:45:49 -0500
In-Reply-To: <20211124204714.82514-3-nayna@linux.ibm.com>
References: <20211124204714.82514-1-nayna@linux.ibm.com>
         <20211124204714.82514-3-nayna@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9F-uV3BV89HIkd5W_HgTufai1Raump-5
X-Proofpoint-ORIG-GUID: Emi7WJWQnWdwKBttCIGldM1kFycgyNmo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-05_03,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0 mlxlogscore=913
 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112050076
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-11-24 at 15:47 -0500, Nayna Jain wrote:
> A new function load_builtin_platform_cert() is defined to load compiled
> in certificates onto the ".platform" keyring.
> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>

Thanks, Nayna.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

