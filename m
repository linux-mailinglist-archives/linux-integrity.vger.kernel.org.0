Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F49561B30
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jun 2022 15:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiF3NVG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jun 2022 09:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiF3NVF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jun 2022 09:21:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA312C65F;
        Thu, 30 Jun 2022 06:21:04 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UCfvdo027105;
        Thu, 30 Jun 2022 13:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Zin55iReFVYask8LlcnJU0tNnOs0FShBSAddaEKcrN0=;
 b=IwFOJybj8W3VuhbmQd9BVR/Kr3MLx63k/LTOZJwQY20DxcTOhQYMvGAuM8SbHC3Z55zM
 4rlpkGOUyiPMC26V0W44XPEpg8gzs/RA0JUeDOW6WLn0+V+AOVwoPF/EgFEifsXM0fW5
 Rc1RBr1GO2SWdgJIdc1QCZVQsCr3H+Mh2kg7NSLN/6rXkTmZqXziV7cQaEx/sBAINs2t
 1/fmEoL1aeemyvzXBRfx3YoneUSNNClasI9Ljga1xj095oLJ91b1HY6KqJCPeJpB/4dd
 OCBpElyQagJWlByKPOhgcIMtsvkxniE53paWgPbEg/GR4IoeX4CRbHeDlMSxlCPP/xBg cA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1c2ch95b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 13:20:57 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25UDIa31019546;
        Thu, 30 Jun 2022 13:20:56 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1c2ch94h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 13:20:56 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25UDKswc024881;
        Thu, 30 Jun 2022 13:20:54 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3gwt0905hg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 13:20:54 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25UDKqMx22020546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 13:20:52 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3988EA4051;
        Thu, 30 Jun 2022 13:20:52 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45E79A4040;
        Thu, 30 Jun 2022 13:20:50 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.82.30])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Jun 2022 13:20:49 +0000 (GMT)
Message-ID: <c0dc0b9dbdc50045ccb5dbdd09ddac1f9a01f7a9.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/5] drivers: of: kexec ima: Support 32-bit platforms
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>, dmitry.kasatkin@gmail.com,
        linux-integrity@vger.kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Date:   Thu, 30 Jun 2022 09:20:48 -0400
In-Reply-To: <20220624044811.9682-2-palmer@rivosinc.com>
References: <20220624044811.9682-1-palmer@rivosinc.com>
         <20220624044811.9682-2-palmer@rivosinc.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ahopxTEWvcumkRLOLUuf7gpLmYE3V92I
X-Proofpoint-GUID: 4rWqa6R6ZJQrqoRJPolKSe2f80WIzXhL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-30_09,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
> RISC-V recently added kexec_file() support, which uses enables kexec
> IMA.  We're the first 32-bit platform to support this, so we found a
> build bug.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

Reviewed-by:  Mimi Zohar <zohar@linux.ibm.com>

