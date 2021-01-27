Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D20305EC3
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Jan 2021 15:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbhA0OzP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Jan 2021 09:55:15 -0500
Received: from mail-db8eur05on2080.outbound.protection.outlook.com ([40.107.20.80]:14849
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234770AbhA0OxD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Jan 2021 09:53:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWLNV4EJnCQKidoXxjg0aPYNPREHnPdXKWfHGSCYHuM23Euny1QIN7g+M4N9c5pdsKbAVpv2t3yhBAbsrPYSdaYpy+DshqY2AP5PYnx/VJ4g7j09pBCgtG6aUx2yUFolhgwS+GxmkwfnrV+Vpggml4Upr8ihMeRr029qPkDoMnbBRXMgTj5QQ+q+4MxXdT0TzsJJzpAKXyIgymh+6Trseel1b1kDBXFDZOl6lmQNvU7EFCcBnHPyMSNNKiG5v6BO84MUy3EQWeluQMXhOHeE070F6TBE3Euve/Cnp2S3VGV7NUlxZmDZBOiRet76uGOUhQ2soPUDwAyF+tUB0f4B4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2MPb76H2RuxK31ygCFx3jTj24WO78XxxU7eMT81Jtc=;
 b=NrUMDFOiLt9AN+qdBG+4FWQ97hgjF9IfSYzbpPv3fUAZ3LxjIyDjy1ADMuIjbos1AMPvtdeY/ruPp9Ch7jF7s9u9O9f0Hgou2DCX9Vy7KrPxnX+ITOG7T12H4w/xGmWisqPZCLWs4OxciBTZNRQBIYW/3nkV4iYmzDwH4WNWrKFL5kX6Pe/NbgkUBwfsPURaHUv5bnHXOAahjFmx00VMJJRFzfU0LUcHVBlHns5MCHSFmswvwL1Z8j4iVp5LipOn05kqaVmSoIq+HHud3W7no46yyT+YpAIoZKuRkTp4ZAiLPJ2Z89BAQL93Wlsz721Tdjp6htWhLC7O71uPM19ujw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=siemens.onmicrosoft.com; s=selector1-siemens-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2MPb76H2RuxK31ygCFx3jTj24WO78XxxU7eMT81Jtc=;
 b=egvQN+jfpmA3izgrSkHLnnTxbtzKf73jE/FEntodeKUTmsdlAXWo43X+1EyA5psIAc5SuAA7M0AoMfcHEPoKQ5Fp32VZAVp6jDCs16aS/3rubXbp8D+hnuNL9nVRDDaUEUZIRaaNJqtxpVElqkwQ8r3RnLab5GzCygzYtAR2JYE=
Received: from AM0PR10MB2548.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:115::16)
 by AM9PR10MB4596.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:272::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.19; Wed, 27 Jan
 2021 14:51:57 +0000
Received: from AM0PR10MB2548.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::61cb:96f8:9a62:c18]) by AM0PR10MB2548.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::61cb:96f8:9a62:c18%4]) with mapi id 15.20.3784.020; Wed, 27 Jan 2021
 14:51:57 +0000
From:   "florian.manoel@siemens.com" <florian.manoel@siemens.com>
To:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC:     "Fuchs, Andreas" <andreas.fuchs@sit.fraunhofer.de>,
        "Peter.Huewe@infineon.com" <Peter.Huewe@infineon.com>,
        "joshz@google.com" <joshz@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: AW: TPM V2: kernel panic on linux reboot
Thread-Topic: TPM V2: kernel panic on linux reboot
Thread-Index: AdbrC5vRfY3emgdzQJCNnKjYyzhKVAAAgKhwAHx7L4AB7rMrkA==
Date:   Wed, 27 Jan 2021 14:51:56 +0000
Message-ID: <AM0PR10MB25481FFED2CDFBEC5596098F84BB0@AM0PR10MB2548.EURPRD10.PROD.OUTLOOK.COM>
References: <VI1PR10MB2559EB47FE26FA85EB4B4D4484A70@VI1PR10MB2559.EURPRD10.PROD.OUTLOOK.COM>
 <VI1PR10MB2559EA5D0EC208129AA503F684A70@VI1PR10MB2559.EURPRD10.PROD.OUTLOOK.COM>
 <YASDd5pphvndrsm+@kernel.org>
In-Reply-To: <YASDd5pphvndrsm+@kernel.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Enabled=true;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SetDate=2021-01-27T14:51:55Z;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Method=Standard;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Name=restricted-default;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ActionId=08649f6a-74b5-42d9-b824-05a29b6a2d83;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ContentBits=0
document_confidentiality: Restricted
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=siemens.com;
x-originating-ip: [165.225.26.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 80a672a5-ba04-47bc-0003-08d8c2d3181e
x-ms-traffictypediagnostic: AM9PR10MB4596:
x-microsoft-antispam-prvs: <AM9PR10MB45967BFBA6D5075D638D00B684BB0@AM9PR10MB4596.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: twUeloAlQo5/MJoH+OTl801Xyp1l+q5zJM/bIOdQMc1CTwUVOg+vPbcmRPruyPcsYv3fR+cwmPF1gXX+ifleXsGgT1TIvxjfelGE9U9WcAUNTbVzbue7jPbimzDZryNMmDvtEeDXHee1XyZPWME4tW5Hfny4bcfUb7k/eui/PwmbuNu2dRoKA9DeyWziUVClKyYUi87a8yEWO4YRpL5zg8L59Qe84zqmgKOPXAF5+P2cShON9veuXk5whtuEPsJRxe4TMYGmvGzidLdQOnZn6MwWSty3ZZkkJZhh9TclO5HhKUyxC17pUPCVb/QRzXwndY7iwSnBUlpKBq8HSI+WRosqIbhtp78R0KJp3Mfsoj1SqgL/vAp7NsSCPZeLXGVb2os2AycKxn6XNSH9fvw8yCA37U1ZBz35MIB2N+o+9YXR2Vnr7jCFufYrveI9VprjDWbAjQ1LiQKVJrR59mVow5xxXnI5A/QROusQzlud31CzOmOHYi4KKaKb4VAc83Sp1YcverL+b9iaBb78FhudnHYKbDYb3W3fYT2RdyDFtNpeg4NqJIAAnz8SMSb8K/scMfGPZAeeHxLzfdWmoXmn1KWyc1kn2kLH9nrTpIFGqwY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2548.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(55016002)(55236004)(71200400001)(15974865002)(83380400001)(8676002)(64756008)(54906003)(8936002)(52536014)(45080400002)(6506007)(9686003)(33656002)(478600001)(86362001)(186003)(966005)(7696005)(5660300002)(26005)(66946007)(30864003)(316002)(66574015)(4326008)(76116006)(66446008)(66556008)(2906002)(6916009)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?Ylo2MxYIca4KuBo1lIA7uaHsw0WVpVdr/o2JPJ/XKOAIFknalrcKvcKxjT?=
 =?iso-8859-1?Q?k/AKgr9tExwMUVPiV6Vsroxiv590H+L71ydKuaydwIWqVCvHs56nYLUgqz?=
 =?iso-8859-1?Q?cCchRrHASfjk/6/qZ8rbU1XRF7J70/KJxje2snvfwV9pBvQy8nHNeb4nJH?=
 =?iso-8859-1?Q?XNhWr92doZvRwuW9Vgla9VA8zo47fwAy1KGYc0SD+ThbaUaiasYQp1YX9u?=
 =?iso-8859-1?Q?ysaClapW3Be+9mTmbWIS78ctRxZahYntCftpSaJ1grwRHDZLQmvvl656yE?=
 =?iso-8859-1?Q?9od8KOtJR+v97cIi1tqnMsynBLJlzqGRu6tBfBzl++4khkKveJoKRbszGZ?=
 =?iso-8859-1?Q?z52TkJ03agMocfCt/o34KLnZgxpxX5lxTd8L0ve8d0cBaVG7Pji9jddEGs?=
 =?iso-8859-1?Q?dnV6TbpGuJrDEz+psnMSVKmwAZsfwRAyJhfiBGQAG8ROUMsSU8qMJh/1lP?=
 =?iso-8859-1?Q?/7zKpNu2w5I+jzFzywD0oSr8bz0pdTpdLUB5YV4LA8gZkdJXzJsG3BFeuW?=
 =?iso-8859-1?Q?+7n2m5N2+RPbt2qpcJJwkC0+SsTjBL8SpuyO1dtUU8rjZYgtfUrxgcwsfW?=
 =?iso-8859-1?Q?DMabMTaOxgOdIgNtOHuvYQhE5VmmDyKvrwywjGotmEJIkVhT5h5em3iR67?=
 =?iso-8859-1?Q?YdOTjBY4MVc8xisCdzWAni+tKrPjuKBPH66TxhK5IQwyrvOPxBzajxDEF9?=
 =?iso-8859-1?Q?y60tTU2osNucc/1ERFS2d3VLyBGHJbIjBjImql4m/uc7Qo8e6rmQmq92kB?=
 =?iso-8859-1?Q?Mp2/fFQU4+n9fcmEtNdZ8xPJ+j4PAI6sF1HjpZgWGGDbxGykU8dgZ/1rrM?=
 =?iso-8859-1?Q?bxxpNnZ5S/fS1bvleInqY3HKlF72E9p+BZGLKVg+ERycrsAO3mSAIxx5SN?=
 =?iso-8859-1?Q?RUsZXAi16pZkMZK46bJnQFli8zrFs8EcjfqJG1QX/guNQvA6ykeS33jjZq?=
 =?iso-8859-1?Q?WEql8i9H13erIjH7oS7ttom/G4FDfBaSeMJOvX51oZ08a8Rys/YEUV4pwB?=
 =?iso-8859-1?Q?B6DvbZhgPwJu98sxpltwssFXiPZN5+FdqFto9WlRBMT0cl9o40nzzahq9i?=
 =?iso-8859-1?Q?JTsfZA9DDGBOl3Bzn9IjHqDeTJkfT9bNO6h/iRzAhpiU?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2548.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a672a5-ba04-47bc-0003-08d8c2d3181e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 14:51:56.9893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fICP0N47+aH/FuQQrTvqj9yBjLUjz7GrU4XebDtLO9c+/xaM36NjGq2zV78Pn1JkS80KwUcFMR4Zx2rEitl6sdSqM4f3uZz+2olI27A5Ou8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4596
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

thanks for your support,
an update on the kernel panic I am experiencing while trying to set up a TP=
M V2 on an ARM64 NXP LS1043a custom board :
We updated the kernel from 4.19.144 to 4.19.165, no changes, the panic is s=
till occurring.

I started to debug, and identify what I believe is the point where this ker=
nel panic is triggered:
'/drivers/char/tpm/tpm-interface.c'

"
	if (chip->ops->clk_enable !=3D NULL)
		chip->ops->clk_enable(chip, true);
"

It looks a lot like an issue that is described here with a TPM 1.2 :
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/01d1d6e2a=
1a74b9b8acba7d5eee67fe83e914aa1

Any idea how to proceed to fix this kernel panic ?

cordially,

Mit freundlichen Gr=FC=DFen
Florian Mano=EBl

Siemens AG
Digital Industries
Process Automation
DI PA DCP R&D 2
=D6stliche Rheinbr=FCckenstr. 50
76187 Karlsruhe, Deutschland
Tel.: +49 721 667-20051
mailto:florian.manoel@siemens.com

www.siemens.com

Siemens Aktiengesellschaft: Vorsitzender des Aufsichtsrats: Jim Hagemann Sn=
abe; Vorstand: Joe Kaeser, Vorsitzender; Roland Busch, Klaus Helmrich, Cedr=
ik Neike, Matthias Rebellius, Ralf P. Thomas, Judith Wiese; Sitz der Gesell=
schaft: Berlin und M=FCnchen, Deutschland; Registergericht: Berlin-Charlott=
enburg, HRB 12300, M=FCnchen, HRB 6684; WEEE-Reg.-Nr. DE 23691322
-----Urspr=FCngliche Nachricht-----
Von: Jarkko Sakkinen <jarkko@kernel.org>=20
Gesendet: Sonntag, 17. Januar 2021 19:36
An: Manoel, Florian (DI PA DCP R&D 2) <florian.manoel@siemens.com>; joshz@g=
oogle.com
Cc: linux-integrity@vger.kernel.org; Fuchs, Andreas <andreas.fuchs@sit.frau=
nhofer.de>; Peter.Huewe@infineon.com
Betreff: Re: TPM V2: kernel panic on linux reboot

On Fri, Jan 15, 2021 at 07:17:01AM +0000, florian.manoel@siemens.com wrote:
>=20
> Hi,
>=20
> this is my first post on this mailing list, so I briefly introduce myself=
. I am Florian Mano=EBl, working at Siemens in Germany.
> I am currently on charge to implement a TPM V2 (Infineon slb9670, SPI con=
nected) on our custom board, named 'LPE9403', equipped with a processor 64-=
bit ARM NXP LS1043a.
> I already made some adjustment (defconfig in U-Boot and Linux, device tre=
e, init code in U-Boot).
> I have installed "tpm2-tools" using 'apt-get install'. I get to the point=
 where the TPM is correctly detected and I can use some of the function lik=
e tpm2_getrandom().
>=20
> However, when I execute the command 'reboot', it leads every time to a ke=
rnel panic. The logs seems to indicate that something went wrong with the s=
hutdown of the TPM.
> In the first time, I wrote to the mailing list of 'tpm2-tools' and got re=
directed here.
> Can you provide me support to fix this issue ?
> My config :
> - Processor 64-bit ARM NXP LS1043a
> - TPM V2 Infineon slb9670
> - linux kernel version: 4.19.144
>=20
> Below the logs of the Linux boot + kernel panic :
> "
> Starting kernel ...
>=20
> [=A0=A0=A0 0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd0=
34]=20
> [=A0=A0=A0 0.000000] Linux version 4.19.144-audis-std (builder@isar) (gcc=
=20
> version 8.3.0 (Debian 8.3.0-2)) #1 SMP PREEMPT Wed Dec 2 12:18:57 UTC=20
> 2020 [=A0=A0=A0 0.000000] Machine model: Siemens LPE9403
>=20
> /*
> Non relevant logs removed
> */
>=20
> [=A0=A0=A0 2.240475] fsl-dspi 2100000.spi: registered master spi3 [=A0=A0=
=A0=20
> 2.245980] spi spi3.3: setup mode 0, 8 bits/w, 18500000 Hz max --> 0 [=A0=
=A0=A0=20
> 2.258637] tpm_tis_spi spi3.3: 2.0 TPM (device-id 0x1B, rev-id 22) [=A0=A0=
=A0=20
> 2.264946] random: fast init done [=A0=A0=A0 2.289984] fsl-dspi 2100000.sp=
i:=20
> registered child spi3.3
>=20
> /*
> Non relevant logs removed
> */
>=20
> Debian GNU/Linux 10 lpe9403-VPM7001303 ttyS0
>=20
> lpe9403-VPM7001303 login: admin
> Last login: Tue Nov 16 02:12:25 UTC 2021 on ttyS0 Linux=20
> lpe9403-VPM7001303 4.19.144-audis-std #1 SMP PREEMPT Wed Dec 2=20
> 12:18:57 UTC 2020 aarch64
>=20
> The programs included with the Debian GNU/Linux system are free=20
> software; the exact distribution terms for each program are described=20
> in the individual files in /usr/share/doc/*/copyright.
>=20
> Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent=20
> permitted by applicable law.
>=20
> admin@lpe9403-VPM7001303:~$ sudo reboot
> =A0=A0=A0=A0=A0=A0=A0=A0 Stoppin[=A0 OK=A0 ] Stopped target Graphical Int=
erface.
> [=A0 OK=A0 ] Stopped Daily Cleanup of Temporary Directories.
> [ =A0OK=A0 ] Stopped Syncronise system .ardware clock every 5 minutes.
> =A0=A0=A0=A0=A0=A0=A0=A0 Stopping watchdog daemon...
> [=A0 OK=A0 ] Stopped Serial Getty on ttyS0.
> [=A0 OK=A0 ] Stopped Wait for ntpd to synchronize system clock.
> [=A0 OK=A0 ] Stopped Session 1 of user admin.
> =A0=A0=A0=A0=A0=A0=A0=A0 Stopping User Manager for UID 1000...
> [=A0 OK=A0 ] Removed slice system-serial\x2dgetty.slice.
> [=A0 OK=A0 ] Stopped User Manager for UID 1000.
> [=A0 OK=A0 ] Stopped watchdog daemon.
> [=A0 OK=A0 ] Stopped target Multi-User System.
> =A0=A0=A0=A0=A0=A0=A0=A0 Stopping DCP daemon...
> =A0=A0=A0=A0=A0=A0=A0=A0 Stopping Login Service...
> =A0=A0=A0=A0=A0=A0=A0=A0 Stopping Event Manager service...
> =A0=A0=A0=A0=A0=A0=A0=A0 Stopping OpenBSD Secure Shell server...
> =A0=A0=A0=A0=A0=A0=A0=A0 Stopping SFP daemon...
> =A0=A0=A0=A0=A0=A0=A0=A0 Stopping Link Layer Discovery Protocol Agent Dae=
mon....
> =A0=A0=A0=A0=A0=A0=A0=A0 Stopping Simple Network Ma.ent Protocol (SNMP) D=
aemon....
> [=A0 OK=A0 ] Stopped target Login Prompts.
> =A0=A0=A0=A0=A0=A0=A0=A0 Stopping Getty on tty1...
> =A0=A0=A0=A0=A0=A0=A0=A0 Stopping Temperature Monitor service...
> =A0=A0=A0=A0=A0=A0=A0=A0 Stopping Network Time Service...
> =A0=A0=A0=A0=A0=A0=A0=A0 Stopping Docker Application Container Engine...
> =A0=A0=A0=A0=A0=A0=A0=A0 Stopping Fail2Ban Service...
> [=A0 OK=A0 ] Stopped Firmware Update Confirmation.
> =A0=A0=A0=A0=A0=A0=A0=A0 Stopping User Runtime Directory /run/user/1000..=
.
> [=A0 OK=A0 ] Unmounted /run/user/1000.
> [=A0 OK=A0 ] Stopped Login Service.
> [=A0 OK=A0 ] Stopped Temperature Monitor service.
> [=A0 OK=A0 ] Stopped SFP daemon.
> [=A0 OK=A0 ] Stopped Event Manager service.
> [=A0 OK=A0 ] Stopped DCP daemon.
> [=A0 OK=A0 ] Stopped Link Layer Discovery Protocol Agent Daemon..
> [=A0 OK=A0 ] Stopped Simple Network Man.ement Protocol (SNMP) Daemon..
> [=A0 OK=A0 ] Stopped Getty on tty1.
> [=A0 OK=A0 ] Stopped Network Time Service.
> [=A0 OK=A0 ] Stopped OpenBSD Secure Shell server.
> [=A0 OK=A0 ] Stopped Docker Application Container Engine.
> [=A0 OK=A0 ] Stopped User Runtime Directory /run/user/1000.
> [=A0 OK=A0 ] Removed slice User Slice of UID 1000.
> =A0=A0=A0=A0=A0=A0=A0=A0 Stopping containerd container runtime...
> [=A0 OK=A0 ] Stopped target Network is Online.
> [=A0 OK=A0 ] Stopped target Host and Network Name Lookups.
> =A0=A0=A0=A0=A0=A0=A0=A0 Stopping Permit User Sessions...
> [=A0 OK=A0 ] Removed slice system-getty.slice.
> [=A0 OK=A0 ] Stopped containerd container runtime.
> [=A0 OK=A0 ] Stopped Permit User Sessions.
> [=A0 OK=A0 ] Stopped Fail2Ban Service.
> [=A0 OK=A0 ] Stopped target Remote File Systems.
> [=A0 OK=A0 ] Stopped target Network.
> =A0=A0=A0=A0=A0=A0=A0=A0 Stopping Network Name Resolution...
> [=A0 OK=A0 ] Stopped Network Name Resolution.
> =A0=A0=A0=A0=A0=A0=A0=A0 Stopping Network Service...
> [=A0 OK=A0 ] Stopped Network Service.
> [=A0 OK=A0 ] Stopped target Network (Pre).
> =A0=A0=A0=A0=A0=A0=A0=A0 Stopping firewalld - dynamic firewall daemon...
> [=A0 OK=A0 ] Stopped firewalld - dynamic firewall daemon.
> =A0=A0=A0=A0=A0=A0=A0=A0 Stopping D-Bus System Message Bus...
> =A0=A0=A0=A0=A0=A0=A0=A0 Stopping Authorization Manager...
> [=A0 OK=A0 ] Stopped D-Bus System Message Bus.
> [=A0 OK=A0 ] Stopped Authorization Manager.
> [=A0 OK=A0 ] Stopped target Basic System.
> [=A0 OK=A0 ] Stopped target Slices.
> [=A0 OK=A0 ] Removed slice User and Session Slice.
> [=A0 OK=A0 ] Stopped target Sockets.
> [=A0 OK=A0 ] Closed lldpad.socket.
> [=A0 OK=A0 ] Closed Docker Socket for the API.
> [=A0 OK=A0 ] Closed sfw_manager socket listener.
> [=A0 OK=A0 ] Closed SWUpdate socket listener.
> [=A0 OK=A0 ] Stopped target Paths.
> [=A0 OK=A0 ] Closed D-Bus System Message Bus Socket.
> [=A0 OK=A0 ] Stopped target System Initialization.
> [=A0 OK=A0 ] Stopped target Swap.
> =A0=A0=A0=A0=A0=A0=A0=A0 Stopping Update UTMP about System Boot/Shutdown.=
..
> [=A0 OK=A0 ] Stopped Apply Kernel Variables.
> =A0=A0=A0=A0=A0=A0=A0=A0 Stopping Load/Save Random Seed...
> [=A0 OK=A0 ] Stopped target Local Encrypted Volumes.
> [=A0 OK=A0 ] Stopped Dispatch Password .ts to Console Directory Watch.
> [=A0 OK=A0 ] Stopped Forward Password R.uests to Wall Directory Watch.
> [=A0 OK=A0 ] Stopped Load Kernel Modules.
> [=A0 OK=A0 ] Stopped Load/Save Random Seed.
> [=A0 OK=A0 ] Stopped Update UTMP about System Boot/Shutdown.
> [=A0 OK=A0 ] Stopped Create Volatile Files and Directories.
> [=A0 OK=A0 ] Stopped target Local File Systems.
> =A0=A0=A0=A0=A0=A0=A0=A0 Unmounting /etc...
> =A0=A0=A0=A0=A0=A0=A0=A0 Unmounting Home mount userdata...
> =A0=A0=A0=A0=A0=A0=A0=A0 Unmounting /var/log...
> [=A0 OK=A0 ] Unmounted /etc.
> [=A0 OK=A0 ] Unmounted Home mount userdata.
> [=A0 OK=A0 ] Unmounted /var/log.
> =A0=A0=A0=A0=A0=A0=A0=A0 Unmounting /userdata...
> [=A0 OK=A0 ] Unmounted /userdata.
> [=A0 OK=A0 ] Reached target Unmount All Filesystems.
> [=A0 OK=A0 ] Stopped target Local File Systems (Pre).
> [=A0 OK=A0 ] Stopped Create Static Device Nodes in /dev.
> [=A0 OK=A0 ] Stopped Create System Users.
> [=A0 OK=A0 ] Stopped Remount Root and Kernel File Systems.
> [=A0 OK=A0 ] Reached target Shutdown.
> [=A0 OK=A0 ] Reached target Final Step.
> [=A0 OK=A0 ] Started Reboot.
> [=A0 OK=A0 ] Reached target Reboot.
> [=A0 675.609520] watchdog: watchdog0: watchdog did not stop!
> [=A0 675.618665] systemd-shutdow: 24 output lines suppressed due to=20
> ratelimiting [=A0 675.662848] systemd-shutdown[1]: Syncing filesystems an=
d block devices.
> [=A0 675.672034] systemd-shutdown[1]: Sending SIGTERM to remaining proces=
ses...
> [=A0 675.686963] systemd-journald[233]: Received SIGTERM from PID 1 (syst=
emd-shutdow).
> [=A0 675.730174] systemd-shutdown[1]: Sending SIGKILL to remaining proces=
ses...
> [=A0 675.743123] systemd-shutdown[1]: Hardware watchdog 'GPIO Watchdog',=
=20
> version 0 [=A0 675.752565] systemd-shutdown[1]: Unmounting file systems.
> [=A0 675.760922] [1021]: Remounting '/' read-only in with options '(null)=
'.
> [=A0 675.782087] EXT4-fs (mmcblk0p1): re-mounted. Opts: (null) [=A0=20
> 675.795819] systemd-shutdown[1]: All filesystems unmounted.
> [=A0 675.801420] systemd-shutdown[1]: Deactivating swaps.
> [=A0 675.806725] systemd-shutdown[1]: All swaps deactivated.
> [=A0 675.811975] systemd-shutdown[1]: Detaching loop devices.
> [=A0 675.820775] systemd-shutdown[1]: All loop devices detached.
> [=A0 675.895298] Unable to handle kernel NULL pointer dereference at=20
> virtual address 0000000000000058 [=A0 675.904126] Mem abort info:
> [=A0 675.906933]=A0=A0 ESR =3D 0x96000005
> [=A0 675.909995]=A0=A0 Exception class =3D DABT (current EL), IL =3D 32 b=
its [=A0=20
> 675.915924]=A0=A0 SET =3D 0, FnV =3D 0 [=A0 675.918989]=A0=A0 EA =3D 0, S=
1PTW =3D 0 [=A0=20
> 675.922138] Data abort info:
> [=A0 675.925012]=A0=A0 ISV =3D 0, ISS =3D 0x00000005 [=A0 675.928856]=A0=
=A0 CM =3D 0,=20
> WnR =3D 0 [=A0 675.931830] user pgtable: 4k pages, 39-bit VAs, pgdp =3D=20
> 00000000bec7a5cc [=A0 675.938447] [0000000000000058]=20
> pgd=3D0000000000000000, pud=3D0000000000000000 [=A0 675.945244] Internal=
=20
> error: Oops: 96000005 [#1] PREEMPT SMP [=A0 675.950807] Modules linked=20
> in: ipt_MASQUERADE(E) nf_conntrack_netlink(E) xt_addrtype(E)=20
> br_netfilter(E) xt_tcpudp(E) ip6t_rpfilter(E) ip6t_REJECT(E)=20
> nf_reject_ipv6(E) ipt_REJECT(E) nf_reject_ipv4(E) xt_conntrack(E)=20
> nft_counter(E) nft_chain_nat_ipv6(E) nf_nat_ipv6(E)=20
> nft_chain_route_ipv6(E) nft_chain_nat_ipv4(E) nf_nat_ipv4(E) nf_nat(E)=20
> nft_chain_route_ipv4(E) nf_conntrack(E) nf_defrag_ipv6(E)=20
> nf_defrag_ipv4(E) ip6_tables(E) nft_compat(E) nf_tables(E)=20
> nfnetlink(E) audis_info(OE) ip_tables(E) x_tables(E) [=A0 675.995303]=20
> Process systemd-shutdow (pid: 1, stack limit =3D 0x0000000010d499d8) [=A0=
=20
> 676.002518] CPU: 0 PID: 1 Comm: systemd-shutdow Tainted: G=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=20
> OE=A0=A0=A0=A0 4.19.144-audis-std #1 [=A0 676.011379] Hardware name: Siem=
ens=20
> LPE9403 (DT) [=A0 676.015902] pstate: 40000005 (nZcv daif -PAN -UAO) [=A0=
=20
> 676.020692] pc : tpm_transmit+0x148/0x678 [=A0 676.024692] lr :=20
> tpm_transmit+0x3b4/0x678 [=A0 676.028691] sp : ffffff800803b840 [=A0=20
> 676.031996] x29: ffffff800803b840 x28: 0000000000000000 [=A0 676.037300]=
=20
> x27: 0000000000000000 x26: 000000000000000c [=A0 676.042604] x25:=20
> ffffff8008d1c508 x24: 0000000000000014 [=A0 676.047908] x23:=20
> 0000000000001000 x22: ffffffc874d37000 [=A0 676.053212] x21:=20
> 0000000000001000 x20: 0000000000000145 [=A0 676.058516] x19:=20
> ffffffc87680c000 x18: 0000000000000000 [=A0 676.063820] x17:=20
> 0000000000000000 x16: 0000000000000000 [=A0 676.069123] x15:=20
> ffffffffffffffff x14: ffffff8008f09848 [=A0 676.074427] x13:=20
> ffffffc873ae391c x12: ffffffc873ae31a9 [=A0 676.079731] x11:=20
> 0101010101010101 x10: 0000000000000040 [=A0 676.085036] x9 : ffffff8008f9=
c8f8 x8 : 0000000000004501 [=A0 676.090339] x7 : ffffffc87680c000 x6 : ffff=
ff800803b8fc [=A0 676.095643] x5 : 0000000000000000 x4 : 0000000000000000 [=
=A0 676.100947] x3 : 0000000000004501 x2 : ffffffc83f794040 [=A0 676.106250=
] x1 : 0000000000000000 x0 : 0000000000000000 [=A0 676.111553] Call trace:
> [=A0 676.113992]=A0 tpm_transmit+0x148/0x678

Thanks for reporting this.

My first guess is that ->pre_shutdown() gets called before this.
It will nullify chip->ops, which will lead to null deref in in tpm_del_char=
_device().

I'm just wondering why this has not shown up earlier..

I mean the callback has been there for a while (since v4.13):

commit d1bd4a792d3961a04e6154118816b00167aad91a
Author: Josh Zimmerman <joshz@google.com>
Date:   Sun Jun 25 14:53:24 2017 -0700

    tpm: Issue a TPM2_Shutdown for TPM2 devices.
   =20
    If a TPM2 loses power without a TPM2_Shutdown command being issued (a
    "disorderly reboot"), it may lose some state that has yet to be
    persisted to NVRam, and will increment the DA counter. After the DA
    counter gets sufficiently large, the TPM will lock the user out.
   =20
    NOTE: This only changes behavior on TPM2 devices. Since TPM1 uses sysfs=
,
    and sysfs relies on implicit locking on chip->ops, it is not safe to
    allow this code to run in TPM1, or to add sysfs support to TPM2, until
    that locking is made explicit.
   =20
    Signed-off-by: Josh Zimmerman <joshz@google.com>
    Cc: stable@vger.kernel.org
    Fixes: 74d6b3ceaa17 ("tpm: fix suspend/resume paths for TPM 2.0")
    Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
    Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
    Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
    Signed-off-by: James Morris <james.l.morris@oracle.com>

> [=A0 676.117646]=A0 tpm_transmit_cmd+0x54/0xe8 [=A0 676.121475]=A0=20
> tpm2_shutdown+0x88/0xa8 [=A0 676.125041]=A0 tpm_chip_unregister+0xc4/0xe0=
=20
> [=A0 676.129130]=A0 tpm_tis_spi_remove+0x24/0x40 [=A0 676.133133]=A0=20
> spi_drv_remove+0x34/0x58 [=A0 676.136788]=A0=20
> device_release_driver_internal+0x1a4/0x238
> [=A0 676.142005]=A0 device_release_driver+0x28/0x38 [=A0 676.146267]=A0=20
> bus_remove_device+0xd4/0x148 [=A0 676.150269]=A0 device_del+0x158/0x388 [=
=A0=20
> 676.153749]=A0 device_unregister+0x24/0x78 [=A0 676.157664]=A0=20
> spi_unregister_device+0x38/0x48 [=A0 676.161926]=A0 __unregister+0x20/0x3=
0=20
> [=A0 676.165407]=A0 device_for_each_child+0x58/0x88 [=A0 676.169669]=A0=20
> spi_unregister_controller+0x44/0x128
> [=A0 676.174364]=A0 dspi_remove+0x28/0x170 [=A0 676.177843]=A0=20
> dspi_shutdown+0x20/0x30 [=A0 676.181410]=A0=20
> platform_drv_shutdown+0x2c/0x38 [=A0 676.185671]=A0=20
> device_shutdown+0x114/0x1f0 [=A0 676.189588]=A0=20
> kernel_restart_prepare+0x44/0x50 [=A0 676.193936]=A0=20
> kernel_restart+0x20/0x68 [=A0 676.197590]=A0 __se_sys_reboot+0x220/0x248 =
[=A0=20
> 676.201505]=A0 __arm64_sys_reboot+0x24/0x30 [=A0 676.205507]=A0=20
> el0_svc_common+0xa4/0x198 [=A0 676.209248]=A0 el0_svc_handler+0x38/0x78 [=
=A0=20
> 676.212988]=A0 el0_svc+0x8/0xe8 [=A0 676.215949] Code: 72000400 b90073e0=
=20
> 54001360 f9435ec0 (f9402c02) [=A0 676.222039] ---[ end trace=20
> 8d405bebaa8bfb3f ]--- [=A0 676.226710] Kernel panic - not syncing:=20
> Attempted to kill init! exitcode=3D0x0000000b [=A0 676.226710] [=A0=20
> 676.235839] Kernel Offset: disabled [ =A0676.239319] CPU features:=20
> 0x0,20002004 [=A0 676.243058] Memory Limit: none [=A0 676.246108]=20
> Rebooting in 90 seconds..
> "
>=20
> If needed, I can provide more information (u-boot logs and init code,=20
> device tree, u-boot and linux defconfig.) Thanks for your support.
>=20
> Mit freundlichen Gr=FC=DFen
> Florian Mano=EBl
>=20
> Siemens AG
> Digital Industries
> Process Automation
> DI PA DCP R&D 2
> =D6stliche Rheinbr=FCckenstr. 50
> 76187 Karlsruhe, Deutschland
> Tel.: +49 721 667-20051
> mailto:florian.manoel@siemens.com
> https://siemens.com/
>=20
> Siemens Aktiengesellschaft: Vorsitzender des Aufsichtsrats: Jim=20
> Hagemann Snabe; Vorstand: Joe Kaeser, Vorsitzender; Roland Busch,=20
> Klaus Helmrich, Cedrik Neike, Matthias Rebellius, Ralf P. Thomas,=20
> Judith Wiese; Sitz der Gesellschaft: Berlin und M=FCnchen, Deutschland;=20
> Registergericht: Berlin-Charlottenburg, HRB 12300, M=FCnchen, HRB 6684;=20
> WEEE-Reg.-Nr. DE 23691322
>=20

/Jarkko
