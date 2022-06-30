Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB4D561B32
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jun 2022 15:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbiF3NVb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jun 2022 09:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbiF3NVa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jun 2022 09:21:30 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511602E681;
        Thu, 30 Jun 2022 06:21:29 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UCrZ2k003773;
        Thu, 30 Jun 2022 13:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=k16NFLQaLIsWbgoHdMs6rta0UMOyNX1vEa8o9kJH92o=;
 b=dGVV2R/zNfhlqwg6OW2NnkjUkD2MjpkMkhAuwZF29n1kWk7SydaO6ApovvW/8wGRv8vH
 7L9ofHh5gi56VRIn+FRUg0BnGl3nWR9gVP8dRqJPTlbDbytskhvTqs3kNTbcaOUthdVI
 fVCVICnKj7+tQQVqAyQCHXfmnWg2yT9pq48JTJnfrfnmS38dNZ3nJdmqOpBq6by3RQal
 YJEbnvvLaB2wSDsTeHlWQ/k0aLVMEITRx8Que3dHiXJu9nij+zXUWEylEkpjKg63EEgx
 am8NlDMZ+7FT/cYw4ptvneWeSLxLOeNCT0VARVQkanudeCXahk89LtheL2eWpY4Q8Zm3 dw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1c82rtt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 13:21:25 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25UCsmgD007638;
        Thu, 30 Jun 2022 13:21:24 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1c82rts8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 13:21:24 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25UDKidV017598;
        Thu, 30 Jun 2022 13:21:23 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 3gwsmhx4aj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 13:21:22 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25UDLKW624051974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 13:21:20 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 787D14C044;
        Thu, 30 Jun 2022 13:21:20 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7A8A4C040;
        Thu, 30 Jun 2022 13:21:18 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.82.30])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Jun 2022 13:21:18 +0000 (GMT)
Message-ID: <9bc64d78110f4768e06138821d3f4b626ac49be2.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/5] ima: Fix a build issue on 32-bit platforms
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>, dmitry.kasatkin@gmail.com,
        linux-integrity@vger.kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Thu, 30 Jun 2022 09:21:17 -0400
In-Reply-To: <20220624044811.9682-3-palmer@rivosinc.com>
References: <20220624044811.9682-1-palmer@rivosinc.com>
         <20220624044811.9682-3-palmer@rivosinc.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2a0oKs2eDejdoDSU3J8bH4h2cgrjjUCc
X-Proofpoint-ORIG-GUID: OZ8KUQFv8BthSrGiXjje1_DGsT0ML3HH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-30_09,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=859
 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206300050
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-06-23 at 21:48 -0700, Palmer Dabbelt wrote:
> ima_dump_measurement_list() took an "unsigned long *", but was passed a
> size_t.  This triggers build warnings on 32-bit RISC-V.
> 
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

Acked-by:  Mimi Zohar <zohar@linux.ibm.com>

