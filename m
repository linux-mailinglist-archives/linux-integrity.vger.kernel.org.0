Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D5B655405
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Dec 2022 20:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbiLWTpp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Dec 2022 14:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbiLWTpo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Dec 2022 14:45:44 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5388E;
        Fri, 23 Dec 2022 11:45:41 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BNJKiee013113;
        Fri, 23 Dec 2022 19:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=0VjRcbZCBRXe7JgT235ScT0fzvlM6Z0t7ke8K+PgjZo=;
 b=SQ3WmqmQOM3ZhaismvJbxmOPz3rwhpoJ5Qlk94QxhWFWr3d189YE9yZvCMgXoma979VL
 d2ga/ijWJiCJKWlkMGYtpHTSduqpXd+ZY7uVvE3XCOecbBKMm0pP3L1jf03f3uEs9Zoe
 MOeHhafVTZ0B587ysju6bwgsLuMvTQ1EF0nt9ya2Opp6VWgNDXwjISVZsBmXmCFp5iMZ
 t7SFxEf8QiVgrSBXfKma3zqi6lsQts9RpJm0CttnjpfBHzNlLhgoRnw3vlpYcH8zUub7
 jLQJdZyT1A5nI9tdk5/ONTyO1oRaOVa48QK+vrmyLwuR+QnIsZSiEG5B5UqQ03lVF1M/ 0w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mnjdfgrmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Dec 2022 19:45:08 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BNJLlUt015476;
        Fri, 23 Dec 2022 19:45:07 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mnjdfgrm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Dec 2022 19:45:07 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BNGFm9h007421;
        Fri, 23 Dec 2022 19:45:06 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3mh6yy980e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Dec 2022 19:45:06 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BNJj4sm65011974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Dec 2022 19:45:04 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DBCD5804C;
        Fri, 23 Dec 2022 19:45:04 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BEF8758056;
        Fri, 23 Dec 2022 19:45:02 +0000 (GMT)
Received: from sig-9-65-251-3.ibm.com (unknown [9.65.251.3])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 23 Dec 2022 19:45:02 +0000 (GMT)
Message-ID: <3d959e693630e7f45a60df2c63be7815cb8136ad.camel@linux.ibm.com>
Subject: Re: [PATCH v3 00/10] Add CA enforcement keyring restrictions
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, Coiby Xu <coxu@redhat.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "pvorel@suse.cz" <pvorel@suse.cz>,
        "noodles@fb.com" <noodles@fb.com>, "tiwai@suse.de" <tiwai@suse.de>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        Elaine Palmer <erpalmer@linux.vnet.ibm.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Date:   Fri, 23 Dec 2022 14:45:02 -0500
In-Reply-To: <61C653C2-A972-40DB-9738-B418A1C601FC@oracle.com>
References: <20221214003401.4086781-1-eric.snowberg@oracle.com>
         <b8e54d077da633132eb6da03ea536face095a425.camel@linux.ibm.com>
         <4CE6F17D-9D87-4024-9E1A-FDFE7C29D5FC@oracle.com>
         <1c51910a35a1d113256494827fd66ccc7473632e.camel@linux.ibm.com>
         <17855993-519C-4DAC-B62F-9DB473CF249B@oracle.com>
         <7df94da37c100c160436892a6996ba30e3fd6dc8.camel@linux.ibm.com>
         <21E52C3E-0778-4908-AF44-F65D57BEC4E0@oracle.com>
         <20221216140648.h32gn5qf3igorpzi@Rk>
         <2d75dfd105f8558ecd1074d64e4252ddd63b698b.camel@linux.ibm.com>
         <0DAFCFC7-29EB-4481-8FF7-616336383378@oracle.com>
         <0fb737ab42ef093f7031a80c8a73f582b1d5c1ae.camel@linux.ibm.com>
         <6AAEC343-E581-4355-ABD8-FE32A1BD16D8@oracle.com>
         <4ac6b5bd1b57bfc0c548e5711e46b341fd5cfe39.camel@linux.ibm.com>
         <D1BF8D7B-F9E4-4C87-9288-534F3AE38ECF@oracle.com>
         <c2b4054c32a24e83186a953ef6e1e3e85aec603b.camel@linux.ibm.com>
         <61C653C2-A972-40DB-9738-B418A1C601FC@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4sof8-uop4afPEMZjyn-if4A_yEd-XJZ
X-Proofpoint-ORIG-GUID: FablEb3N1zuRZLOJ8I0k5jfK7BPUlzce
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-23_06,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=536
 suspectscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212230164
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2022-12-23 at 18:17 +0000, Eric Snowberg wrote:
> >> Fair enough.  If this will be viewed as justification for adding the additional 
> >> code, I can work on adding it.  Above you mentioned a warning would be needed 
> >> at a minimum and a restriction could be placed behind a Kconfig.  How about for 
> >> the default case I add the warning and when compiling with 
> >> INTEGRITY_CA_MACHINE_KEYRING the restriction will be enforced.
> > 
> > Sounds good to me.  To avoid misunderstandings, will there be a Kconfig
> > menu with 3 options?  
> 
> I will add the three options in the next round.
> 
> > There were a couple of other comments having to
> > do with variable names.  Will you address them as well?
> 
> And take care of the variable name changes.  I won’t get back to this until January.

Enjoy your vacation and the holidays.  Looking forward to the next
version.

-- 
thanks,

Mimi

