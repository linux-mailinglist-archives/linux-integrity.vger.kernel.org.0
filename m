Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53AFD1FBCAD
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jun 2020 19:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgFPRT5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jun 2020 13:19:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46452 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727859AbgFPRT5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jun 2020 13:19:57 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05GH3Jv1173842
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jun 2020 13:19:56 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31q23srjcx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jun 2020 13:19:56 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05GHG7h2005506
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jun 2020 17:19:54 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 31mpe85qha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jun 2020 17:19:54 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05GHJq7921626884
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jun 2020 17:19:52 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E01542041;
        Tue, 16 Jun 2020 17:19:52 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8928842047;
        Tue, 16 Jun 2020 17:19:51 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.158.198])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 16 Jun 2020 17:19:51 +0000 (GMT)
Message-ID: <1592327991.11061.205.camel@linux.ibm.com>
Subject: Re: [PATCH] ima_evm_utils: extended calc_bootaggr to PCRs 8 - 9
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Maurizio Drocco <maurizio.drocco@ibm.com>,
        linux-integrity@vger.kernel.org
Date:   Tue, 16 Jun 2020 13:19:51 -0400
In-Reply-To: <20200616120228.16068-1-maurizio.drocco@ibm.com>
References: <20200616120228.16068-1-maurizio.drocco@ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-16_10:2020-06-16,2020-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 cotscore=-2147483648 bulkscore=0 adultscore=0 mlxlogscore=922
 lowpriorityscore=0 spamscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006160120
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Maurizio,

On Tue, 2020-06-16 at 08:02 -0400, Maurizio Drocco wrote:
> From: Maurizio <maurizio.drocco@ibm.com>
> 
> If PCRs 8 - 9 are set (i.e. not all-zeros), cal_bootaggr should include
> them into the digest.
> 
> Signed-off-by: Maurizio Drocco <maurizio.drocco@ibm.com>

Thank you, this patch seems to be working properly.  As a separate
patch, could you fix the tests/boot_aggregate.test comments "PCRs 0
-7" and other things, like displaying just PCRs 0 - 7?

thanks,

Mimi
