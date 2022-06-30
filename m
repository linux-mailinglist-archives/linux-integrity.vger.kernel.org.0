Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923FE561B35
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jun 2022 15:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbiF3NWP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jun 2022 09:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234731AbiF3NWJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jun 2022 09:22:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320D12CCA2;
        Thu, 30 Jun 2022 06:22:09 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UCCQiF021464;
        Thu, 30 Jun 2022 13:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Gz5rGKtpdQID8m6HmioTidsQ2SmRszmdxDHeu0i98ho=;
 b=HM0UuS4YYa1vixPvyBe6Vu9a1Fk+BHF5GC5p408SmUkVNQUx/0CWBhnTeY9r+mNmZB7N
 aEn0D4mbmhY/x7+iuEhnrOpwV0lMyoh99jVMDa43azLF9rbjwbRo4RV4EwJ+eu3DizsP
 DLWb5AK/JGrvMh1EgKuDzlYr46jCUTRap0mksaQGANInXC0BNvF0RBSQCGGqajsGM8xR
 Neww2acpfbyLrcRLXFvWt7o60N/O0yZy2dvLcwVSt2AITyBlHtxMTyCSRBE8WR9cl+KF
 dZZDnzyJcp5tyQ/gx7UkCZQDn2LAF3M2aFNnOUCVIa86Gw5ZIQ9xGTzbHCJEvQj57feW AQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1bmmt7e7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 13:22:03 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25UCGTHS037328;
        Thu, 30 Jun 2022 13:22:02 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1bmmt7d5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 13:22:02 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25UDLJOo013809;
        Thu, 30 Jun 2022 13:22:00 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3gwt09056p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 13:22:00 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25UDLw6923855568
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 13:21:58 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03F6011C04A;
        Thu, 30 Jun 2022 13:21:58 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A98611C050;
        Thu, 30 Jun 2022 13:21:56 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.82.30])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Jun 2022 13:21:56 +0000 (GMT)
Message-ID: <1c9924ca8c93182d8673064cd02262b75857fe67.camel@linux.ibm.com>
Subject: Re: [PATCH v2 0/5] Support kexec_file on 32-bit RISC-V
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>, dmitry.kasatkin@gmail.com,
        linux-integrity@vger.kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Thu, 30 Jun 2022 09:21:55 -0400
In-Reply-To: <20220624044811.9682-1-palmer@rivosinc.com>
References: <20220624044811.9682-1-palmer@rivosinc.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ff9ylWNk9uhWoXrVL2dO4Uh6CLqcKXp_
X-Proofpoint-ORIG-GUID: d06SwYGMN-EpKPgDWtITZ5KlqDrEIo08
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-30_09,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=928
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206300052
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Palmer,

On Thu, 2022-06-23 at 21:48 -0700, Palmer Dabbelt wrote:
> This rolled itself back to the top of my inbox, so I figured I'd send it
> again as Rob's review landed.  IMO the security/integrity/ima/ change is
> sufficiently trivial that it's fine to take it through the RISC-V tree
> but I don't have an Review/Ack so I'll wait until this loops back again
> to give the security/integrity/ folks a chance to chime in.
> 
> If this loops back to the top of my queue (which looks about a month
> deep right now) without any comments then I'll put it in riscv/for-next.
> 
> Thanks!
> 
> Changes since v1
> <https://lore.kernel.org/all/20220520154430.18593-1-palmer@rivosinc.com/>
> * Collected reviews for drivers/of/kexec.c.

Maybe better that you upstream the RISC-V changes.  So far there aren't
any merge conflicts with this patchset, but a number of other kexec
patch sets will hopefully be upstreamed in the coming open window.  I'd
appreciate if you could create a topic branch for the first two
patches.

thanks,

Mimi

