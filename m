Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067C5528787
	for <lists+linux-integrity@lfdr.de>; Mon, 16 May 2022 16:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244557AbiEPOuU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 May 2022 10:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244710AbiEPOuR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 May 2022 10:50:17 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F41C2EA3E;
        Mon, 16 May 2022 07:50:12 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GDl4gj031239;
        Mon, 16 May 2022 14:50:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=UfqGtL3Cr2ukJ7OfAQ9tgKlGz5nWQIeVs7+939f80o8=;
 b=GXi5HgbPDL03u3w2r1aOchyLfwQm5XwmhtWqqBvoGN14E6vporR7FpT1yPDygNieoc2q
 +MqJRN7mNPjAf5AC7uxCLGAN8MxyNY2lPTrRddbdERKQqFavRtwUL6cF/+NcHNZaC3XK
 zVypu+XnxWgWdy78iDJMFO52dniNgEUKGffmdxx9lOq+KFqXQToWwsq1hvZdcFmyi9kx
 9BuD+NEr/kT87X8IpH43ccOiw3ezfPWCPMu0PcMzsbr1WB+LT195EA1EYd/cSZHlBwRn
 xgKvTHksMzVbTbBZ5w6+nF7vfCLs8GHIYuVrQCQPlRAFH7axEzwK0MkA9xJa8xUdbl3g 4Q== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g3qt5hm9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 14:50:11 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24GEm6ol011710;
        Mon, 16 May 2022 14:50:09 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3g23pjav6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 14:50:09 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24GEaIwL54657290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 14:36:18 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 279FCA4040;
        Mon, 16 May 2022 14:50:06 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63AB5A404D;
        Mon, 16 May 2022 14:50:05 +0000 (GMT)
Received: from sig-9-65-83-206.ibm.com (unknown [9.65.83.206])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 16 May 2022 14:50:05 +0000 (GMT)
Message-ID: <6d91e146702bcaf361cb193eaca35c57e38482df.camel@linux.ibm.com>
Subject: Re: [PATCH] evm: Clean up some variables
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 16 May 2022 10:50:04 -0400
In-Reply-To: <20220513174105.3684229-1-stefanb@linux.ibm.com>
References: <20220513174105.3684229-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ci0QwfriHJ-YhCy-jrZg5I23jF3Ns5n7
X-Proofpoint-ORIG-GUID: ci0QwfriHJ-YhCy-jrZg5I23jF3Ns5n7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-16_13,2022-05-16_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 mlxlogscore=769 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205160079
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2022-05-13 at 13:41 -0400, Stefan Berger wrote:
> Make hmac_tfm static since it's not used anywhere else besides the file
> it is in.
> 
> Remove declaration of hash_tfm since it doesn't exist.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Thanks, Stefan.   Both this patch and "evm: Return INTEGRITY_PASS for
enum integrity_status value '0'"  are now queued in next-integrity.

Mimi

