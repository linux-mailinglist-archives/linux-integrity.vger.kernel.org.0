Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7530B5293D4
	for <lists+linux-integrity@lfdr.de>; Tue, 17 May 2022 00:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349794AbiEPWuP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 May 2022 18:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349772AbiEPWuM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 May 2022 18:50:12 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CE443EFE;
        Mon, 16 May 2022 15:50:11 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GKixHF017960;
        Mon, 16 May 2022 22:50:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=gfTmdZg2R6iesNFeLO9g31D6moYj/CqEIy7Ppd+BVBs=;
 b=b09tpDpGg1nroHs7o348ROGPDg2pu1bxRaf4yMIsNnMOTdNBAGVo/X9A2KrhQTcSI7I+
 XFQSrtWsDLvwxjP6eHQ400dNEPVo0P7km9d9iGY4fjWiARSHvBCfap5nCRkibaetw29a
 0kppDrhvKL6FFEEhXCht8nESBJbIa/85aR30kj8D1yZFlDld0ep6H+WEgFhgczz4sEXM
 RoKA7HviOC5zytvBU6Lw0AtMJQDw5akCZSvULY2QBbSgDTztXPOmBmaC0e6JqI3POvfk
 xszZ8/4ACFC/jEraFXXDa+xwrH1jAu5duimRHuNvEDCTlVts9CODD7TMd+uPgsnJyXvT Iw== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g3wx21v4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 22:50:10 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24GMmChS019199;
        Mon, 16 May 2022 22:50:08 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 3g2428tm5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 22:50:08 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24GMo4DK47382838
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 22:50:04 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB4B7AE04D;
        Mon, 16 May 2022 22:50:04 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A9E9AE045;
        Mon, 16 May 2022 22:50:04 +0000 (GMT)
Received: from sig-9-65-83-206.ibm.com (unknown [9.65.83.206])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 16 May 2022 22:50:03 +0000 (GMT)
Message-ID: <883edebc6d2260dc0c7480cac11805a30bf11931.camel@linux.ibm.com>
Subject: Re: [PATCH] evm: Clean up some variables
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 16 May 2022 18:50:03 -0400
In-Reply-To: <b01b3269-626f-5918-41c0-08c05518525a@linux.ibm.com>
References: <20220513174105.3684229-1-stefanb@linux.ibm.com>
         <6d91e146702bcaf361cb193eaca35c57e38482df.camel@linux.ibm.com>
         <b01b3269-626f-5918-41c0-08c05518525a@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3QTm2SA0L4JKEQ_QERyNvzb7OhyYbN_6
X-Proofpoint-ORIG-GUID: 3QTm2SA0L4JKEQ_QERyNvzb7OhyYbN_6
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-16_16,2022-05-16_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=695 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205160124
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2022-05-16 at 11:27 -0400, Stefan Berger wrote:
> 
> On 5/16/22 10:50, Mimi Zohar wrote:
> > On Fri, 2022-05-13 at 13:41 -0400, Stefan Berger wrote:
> >> Make hmac_tfm static since it's not used anywhere else besides the file
> >> it is in.
> >>
> >> Remove declaration of hash_tfm since it doesn't exist.
> >>
> >> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > 
> > Thanks, Stefan.   Both this patch and "evm: Return INTEGRITY_PASS for
> > enum integrity_status value '0'"  are now queued in next-integrity.
> > 
> > Mimi
> > 
> 
> There's also this one here:
> 
> https://lore.kernel.org/all/20220421175205.798974-1-stefanb@linux.ibm.com/

Thanks for the reminder.  It's now queued in next-integrity.

Mimi

