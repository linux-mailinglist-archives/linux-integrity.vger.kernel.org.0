Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E4C570D24
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Jul 2022 00:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbiGKWFZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 Jul 2022 18:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbiGKWFV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Jul 2022 18:05:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953EE52DFC;
        Mon, 11 Jul 2022 15:05:18 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BL1eOW026600;
        Mon, 11 Jul 2022 22:05:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=0UYMY/8LSqYL9C1gfOyC9V3xGiHgeAVl6rhJahtce6Q=;
 b=H94rq4WcoObqeBYWGSXJURwJUm5ci5Mc/ycO4GQ/G1sZrqEOYRdO/ShJka+NP6Art3bI
 QN6XBNv7+ii1qKmkEbHaYt2IJz0XIy7TMDLUAjdr2sV/64tlDhSXRIMw+k4D4IecYYfP
 rwscuPYr2NUp1jZgp/qfJGU5bpH6O0Ci3PbO0aNpUGF4KakrVSR5MKQa1uxNueJKUR8Q
 XtHSpO1svbyrVIKvJMEhebHsGsJ+4EX5oAWyQ5DsPjP/XR7bI50clr+O5OP4U5FfpM/w
 tOsRhwKeTlcqmSnnJC2oSoxca5aayfMRgIfKQ8ozEPhqAqdtVOuIEgj1Csy4oA4OrH2O Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h8udv16r8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 22:05:11 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26BM14qi028560;
        Mon, 11 Jul 2022 22:05:11 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h8udv16ps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 22:05:10 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26BLqFHo008582;
        Mon, 11 Jul 2022 22:05:08 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3h71a8tf37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 22:05:08 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26BM3bYY18809274
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 22:03:37 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4452A4053;
        Mon, 11 Jul 2022 22:05:04 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19098A4051;
        Mon, 11 Jul 2022 22:05:02 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.107.19])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 Jul 2022 22:05:01 +0000 (GMT)
Message-ID: <5f205957701fd4927d822221fcb5552134091e1e.camel@linux.ibm.com>
Subject: Re: [PATCH v6 5/6] of: kexec: Refactor IMA buffer related functions
 to make them reusable
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>, kexec@lists.infradead.org,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     nayna@linux.ibm.com, nasastry@in.ibm.com, mpe@ellerman.id.au,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Date:   Mon, 11 Jul 2022 18:05:00 -0400
In-Reply-To: <20220707172026.831614-6-stefanb@linux.ibm.com>
References: <20220707172026.831614-1-stefanb@linux.ibm.com>
         <20220707172026.831614-6-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hqoOL2CMUJUn5qgWL5bRBtIiAkrrg-ZD
X-Proofpoint-ORIG-GUID: iG-GAhJJtFe1gvh7lTleTLoaSt3-nQll
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-11_25,2022-07-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 adultscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207110089
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-07-07 at 13:20 -0400, Stefan Berger wrote:
> Refactor IMA buffer related functions to make them reusable for carrying
> TPM logs across kexec.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Mimi Zohar <zohar@linux.ibm.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

